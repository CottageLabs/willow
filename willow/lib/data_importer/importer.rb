require 'aws-sdk'
require 'fileutils'

module DataImporter
  class Importer

    UNKNOWN = 'UNKNOWN'.freeze
    attr_reader :hash, :collection, :bucket, :import_dir, :filter
    # http://testdata.researchdata.alpha.jisc.ac.uk.s3.eu-west-2.amazonaws.com/
    def initialize(bucket: 'test-importer-data', region: 'eu-west-2',
                   import_dir: 'tmp/importer', filter: nil,
                   collection_id: nil, importing_user_email: nil)
      @s3 = Aws::S3::Client.new(region: region)
      @bucket = bucket
      @import_dir = import_dir
      @filter = filter
      @collection_id = collection_id
      @importing_user_email = importing_user_email
      @collection = []
      @hash = {}

      @vocabs = VocabularyImporter.new('seed/jisc-rdss-datamodels')
    end



    def sync_with_s3
      puts "Synchronising with S3"
      unless File.directory?(@import_dir)
        FileUtils.mkdir_p(@import_dir)
      end

      @s3.list_objects_v2(bucket: @bucket).each do |response|
        response.contents.each do |item|

          # we are only interested in files
          unless item.key.ends_with?('/')

            if @filter.nil? || @filter.present? && item.key.starts_with?(@filter)

              # Download the S3 files, unless they are already downloaded
              filename = File.join(@import_dir, item.key)
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
                hash[dirname][:metadata] = filename
              end
              hash[dirname][:files].append(filename)

            else
              puts "Ignoring #{item.key} (filter: #{@filter})"
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
        metadata = JSON.parse(File.read(item[:metadata]))

        puts metadata

        work = RdssDataset.where(id: item[:id]).first || RdssDataset.new() #id: item[:id])
        work.title = [metadata['objectTitle'].present? ? metadata['objectTitle'] : UNKNOWN]

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
          work.license_nested_attributes = metadata["objectRights"].map {|i| { label: i["licenceName"] || UNKNOWN } }
        end

        # This causes a term error - need to investigate why
        # if metadata["objectDate"].present?
        #   work.date_attributes = metadata["objectDate"].map {|i|
        #     {
        #       date: i['dateValue'],
        #       description: @vocabs.vocabularies["dateType"][i["dateType"]]
        #     }
        #   }
        # end

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
          Hydra::Works::UploadFileToFileSet.call(fileset, open(file))
          CreateDerivativesJob.perform_now(fileset, fileset.files.first.id)
          work.ordered_members << fileset
          fileset.save!

          unless work.representative_id.present?
            work.representative_id = fileset.id
            work.thumbnail_id = fileset.thumbnail_id
          end
        end

        work.save!

        puts item[:files]

        # NB ordered_members is important here; members will not appear in blacklight!
        #work.ordered_members <<






        puts "-----------------"
        puts "ID: #{item[:id]}"
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


      end

      self
    end

  end
end

