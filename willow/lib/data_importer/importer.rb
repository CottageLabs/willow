require 'aws-sdk'
require 'fileutils'

module DataImporter
  class Importer

    UNKNOWN = 'UNKNOWN'.freeze
    attr_reader :hash, :collection, :bucket, :import_dir, :filter

    def initialize(bucket: , region:, prefix:,
                   import_folder: 'tmp/importer', import_filter: nil,
                   import_user: nil, import_collection_id: nil,
                   import_visibility: 'open')
      @s3 = Aws::S3::Client.new(region: region)
      @bucket = bucket
      @prefix = prefix
      @import_folder = import_folder
      @import_filter = import_filter
      @import_user = import_user
      @import_collection_id = import_collection_id
      @import_visibility = import_visibility

      if @import_collection_id.present?
        @import_collection = Collection.find(@import_collection_id)
      else
        @import_collection = nil
      end

      @collection = []
      @hash = {}


      @vocabs = VocabularyImporter.new('seed/jisc-rdss-datamodels')
    end



    def sync_with_s3
      puts "Synchronising with S3"
      unless File.directory?(@import_folder)
        FileUtils.mkdir_p(@import_folder)
      end

      @s3.list_objects_v2(bucket: @bucket, prefix: @prefix).each do |response|
        response.contents.each do |item|

          # we are only interested in files
          unless item.key.ends_with?('/')

            if @import_filter.nil? || @import_filter.present? && item.key.starts_with?(@import_filter)

              # Download the S3 files, unless they are already downloaded
              filename = File.join(@import_folder, item.key)
              dirname = File.dirname(filename)
              # unless the file is already on disk and the sizes match, copy the file to disk
              if File.exist?(filename) && File.size(filename) == item.size
                puts "Skipping download of #{item.key}"
              else
                puts "Downloading #{item.key} (#{item.size})"
                unless File.directory?(dirname)
                  FileUtils.mkdir_p(dirname)
                end
                @s3.get_object(response_target: filename, bucket: @bucket, key: item.key)
              end

              hash[dirname] ||= {
                  id: File.dirname(item.key),
                  metadata: nil,
                  files: []
              }

              if File.basename(filename) == 'metadata.json'
                hash[dirname][:metadata_file] = filename
              end

              # we don't actually want to load the metadata files as part of the repository item
              unless ['metadata.json', 'original_oai_dc_metadata.json'].include?(File.basename(filename))
                hash[dirname][:files].append(filename)
              end
            else
              puts "Ignoring #{item.key} (filter: #{@import_filter})"
            end
          end

        end
      end

      @collection = @hash.map{|key,value| value}
      self
    end


    def import_into_willow
      puts "Importing into Willow"

      @collection.each do |item|

        begin

          puts "Importing #{item[:metadata_file]}..."

          work = import_item(item)

          puts "ID: #{work.id}"
          puts "TITLE: #{work.title.to_json}"
          work.creator_nested.each do |i|
            puts "CREATOR: #{i.to_json}"
          end
          work.license_nested.each do |i|
            puts "LICENSE: #{i.to_json}"
          end
          work.date.each do |i|
            puts "DATE: #{i.to_json}"
          end
          puts "KEYWORD: #{work.keyword.to_json}"
          puts "CATEGORY: #{work.category.to_json}"
          puts "RESOURCE-TYPE: #{work.resource_type.to_json}"
          work.identifier_nested.each do |i|
            puts "IDENTIFIER: #{i.to_json}"
          end
          work.relation.each do |i|
            puts "RELATION: #{i.to_json}"
          end
          work.organisation_nested.each do |i|
            puts "ORGANISATION: #{i.to_json}"
          end

          puts "-------"


        rescue Exception => e
          puts "ERROR during import of #{item[:metadata_file]}"
          puts e.message
          puts e.backtrace.inspect

        end

      end

    end


    def import_item(item)
      metadata = JSON.parse(File.read(item[:metadata_file]))

      work = RdssDataset.where(id: item[:id]).first || RdssDataset.new() #id: item[:id])
      work.title = [metadata['objectTitle'].present? ? metadata['objectTitle'] : UNKNOWN]
      work.visibility = @import_visibility
      work.state = Vocab::FedoraResourceStatus.active
      work.date_uploaded = DateTime.now.utc
      work.import_url = item[:metadata_file]
      work.rights_statement = [UNKNOWN] #['http://rightsstatements.org/vocab/CNE/1.0/'] # Copyright not evaluated
      work.depositor = @import_user if @import_user.present?

      if metadata["objectPersonRole"].present?
        work.creator_nested_attributes = metadata["objectPersonRole"].map { |i|
          {
            name: i["person"]["personIdentifierValue"] || UNKNOWN,
            orcid: UNKNOWN,
            role: @vocabs.vocabularies["personRole"][i["role"]]
          }
        }
      end

      work.description = [metadata['objectDescription']] if metadata["objectDescription"].present?

      if metadata["objectRights"].present?
        work.license_nested_attributes = metadata["objectRights"].map {|i|
          {
              label: i["licenceName"] || UNKNOWN,
              webpage: i["licenceIdentifier"] || UNKNOWN
          }
        }
      else
        work.license_nested_attributes = [
          {
              label: UNKNOWN,
              webpage: UNKNOWN
          }
        ]
      end

      # All works require a rights holder, however this field is not present in the metadata
      work.rights_holder = [UNKNOWN]

      if metadata["objectDate"].present?
        work.date_attributes = metadata["objectDate"].map {|i|
          {
            date: i['dateValue'],
            description: @vocabs.vocabularies["dateType"][i["dateType"]]
          }
        }
      end

      work.keyword = metadata["objectKeywords"] if metadata["objectKeywords"].present?
      work.category = metadata["objectCategory"] if metadata["objectCategory"].present?
      work.resource_type = [@vocabs.vocabularies["resourceType"][metadata["objectResourceType"]]] if metadata["objectResourceType"].present?

      if metadata["objectIdentifier"].present?
        work.identifier_nested_attributes = metadata["objectIdentifier"].map {|i|
          {
            obj_id: i['identifierValue'],
            obj_id_scheme: @vocabs.vocabularies["identifierType"][i["identifierType"]] || UNKNOWN
          }
        }
      end

      if metadata["objectRelatedIdentifier"].present?
        work.relation_attributes = metadata["objectRelatedIdentifier"].map {|i|
          {
              label: UNKNOWN,
              url: UNKNOWN,
              identifier: i['identifierValue'],
              identifier_scheme: @vocabs.vocabularies["identifierType"][i["identifierType"]] || UNKNOWN,
              relationship_name: UNKNOWN,
              relationship_role: UNKNOWN
          }
        }
      end


      if metadata["objectOrganisationRole"].present?
        work.organisation_nested_attributes = metadata["objectOrganisationRole"].map {|i|
          {
              name: i['organisation']['organisationName'] || UNKNOWN,
              role: @vocabs.vocabularies["organisationRole"][i["role"]] || UNKNOWN,
              identifier:  @vocabs.vocabularies["organisationType"][i["organisation"]["organisationType"]] || UNKNOWN,
              uri: UNKNOWN
          }
        }
      end

      item[:files].each do |file|
        fileset = FileSet.create(label: File.basename(file), title: [File.basename(file)])
        fileset.visibility = @import_visibility
        Hydra::Works::UploadFileToFileSet.call(fileset, open(file))
        CharacterizeJob.perform_now(fileset, fileset.files.first.id)
        work.ordered_members << fileset
        fileset.save!

        unless work.representative_id.present?
          work.representative_id = fileset.id
          work.thumbnail_id = fileset.thumbnail_id
        end
      end

      work.save!

      # add work to collection if provided
      if @import_collection.present?
        unless @import_collection.members.include?(work)
          puts "Adding work to collection"
          @import_collection.ordered_members << work
          @import_collection.save!
        end
      end

      # send message to api
      ActiveSupport::Notifications.instrument(Hyrax::Notifications::Events::METADATA_CREATE, {
          curation_concern_type: work.class, object: work})

      work
    end

  end
end

