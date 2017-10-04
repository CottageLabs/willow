require 'aws-sdk'
require 'fileutils'

module DataImporter
  class Importer

    attr_reader :hash, :collection, :bucket, :import_dir, :filter
    # http://testdata.researchdata.alpha.jisc.ac.uk.s3.eu-west-2.amazonaws.com/
    def initialize(bucket: 'test-importer-data', region: 'eu-west-2', import_dir: 'tmp/imports', filter: nil,
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
              else
                hash[dirname][:files].append(filename)
              end

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




        work = Book.where(id: item[:id]).first || Book.new(id: item[:id])
        work.title = [item['objectTitle']]





        puts "ID: #{item[:id]}"
        puts "RESOURCE TYPE: #{@vocabs.vocabularies["resourceType"][metadata["objectResourceType"]]}"

        metadata["objectIdentifier"].each do |i|
          puts "IDENTIFIER: #{@vocabs.vocabularies["identifierType"][i["identifierType"]]} : #{i["identifierValue"]}"
        end

        metadata["objectPersonRole"].each do |i|
          puts "PERSON: #{@vocabs.vocabularies["personRole"][i["role"]]} : #{i["person"]["personIdentifierValue"]} : #{@vocabs.vocabularies["personIdentifierType"][i['person']['personIdentifierType']]} "
        end




        # #puts metadata
        #
        # puts "TESST1"
        # puts metadata["objectResourceType"]
        # # objectResourceType is resourceType
        # puts @vocabs.vocabularies["resourceType"][metadata["objectResourceType"]]

      end

      self
    end

  end
end


# puts JSON.pretty_generate(hash)


    # def parse_entry(item, collection, s3)
    #   # ignore folders, just focus on files
    #   if !item.key.ends_with?('/')
    #     dirs, _, filename = item.key.rpartition('/')
    #     collection[dirs] ||= {}
    #
    #     if filename == 'metadata.json'
    #       collection[dirs][:metadata] = JSON.parse('{}')
    #
    #       #s3.get_object(item)
    #
    #       resp = s3.get_object(bucket: 'test-importer-data', key: item.key)
    #       puts resp.body.read
    #
    #
    #     end
    #
    #
    #
    #
    #   end
    #
    #   # dirs = key.split("/")
    #   # dirs.each do |dir|
    #   #   hash[dir]
    #   # end
    #
    #
    # end

    # def parse_dirs(dirs)
    #
    # end
    #
    #
    #
    # def split_into_hash(path, hash={})
    #
    #   outer, inner = path.split("/", 2)
    #   if inner
    #     hash[outer] = (hash[outer] || {}).merge(split_into_hash(inner))
    #   else
    #     hash[outer] = (hash[outer] || {}).merge({})
    #   end
    #   hash
    # end




      #
      #
      #
      #
      # components = path.split("/")
      # is_dir = path.ends_with?("/")
      #
      #
      # components.each do |c|
      #   h[c] ||= {}




    #end

