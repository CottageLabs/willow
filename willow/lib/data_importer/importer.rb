require 'aws-sdk'

module DataImporter
  class Importer

    def initialize(bucket: 'test-importer-data', region: 'eu-west-2')
      s3 = Aws::S3::Client.new(region: region)

      s3.list_objects_v2(bucket: bucket).each do |response|
        # puts response


        tree = {}

        # This code intends to iterate through an AWS bucket to construct a hash-tree
        # /folder1/folder2/folder3/fileA
        # /folder1/folder2/folder3/fileB
        # /folder1/folder2/fileC
        # should result in:
        # { folder1: {folder2: {folder3: { fileA: {}, fileB: {} }, fileC: {} } } }
        # However it is still work in progress!

        response.contents.each do |item|
          # puts "item"
          # puts item
          puts item.key

          split_into_hash(item.key, tree)

          # puts item.class
        end
        
        puts tree


        # puts response.contents.map(&:key)
        #
        # puts response.contents.each.map do |c|
        #   puts c.inspect
        # end
      end

    end

    def split_into_hash(path, hash={})

      outer, inner = path.split("/", 2)
      if inner
        hash[outer] = (hash[outer] || {}).merge(split_into_hash(inner))
      else
        hash[outer] = (hash[outer] || {}).merge({})
      end
      hash
    end




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




    end

  end
end
