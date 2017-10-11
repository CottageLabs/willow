require 'json'
module DataImporter
  class VocabularyImporter

    attr_reader :vocabularies

    def initialize(directory)
      # read all the JISC RDSS json data models in the specified folder
      @vocabularies = {}

      if Dir.exist?(directory)
        Dir.glob(File.join(directory, "*.json")).each do |filename|
          puts "Reading #{filename}"

          vocab = JSON.parse(File.read(filename))

          @vocabularies[vocab["vocabularyName"]] ||= {}

          vocab["vocabularyValues"].each do |vocab_value|
            @vocabularies[vocab["vocabularyName"]][vocab_value["valueId"]] = vocab_value["valueName"]
          end

        end
      else
        puts "ERROR: directory not found: #{directory}"
      end
    end
  end
end
