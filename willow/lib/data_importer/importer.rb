require 'aws-sdk'

module DataImporter
  class Importer

    def initialize(bucket: 'test-importer-data', region: 'eu-west-2')
      s3 = Aws::S3::Client.new(region: region)

      s3.list_objects_v2(bucket: bucket).each do |response|
        # puts response


        x = {}

        response.contents.each do |item|
          # puts "item"
          # puts item
          puts item.key

          puts item.key.split("/").inspect
          # puts item.class
        end


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
        hash[outer] = split_into_hash(inner)
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
