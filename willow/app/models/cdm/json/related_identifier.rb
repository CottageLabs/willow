module Cdm
  module Json
    class RelatedIdentifier < ::Cdm::Json::ModelBase
      attr_reader :relation_type, :identifier_type, :identifier_value
      def initialize(values={})
        @relation_type = values['relation_type']
        identifier = values['identifier']
        if(identifier)
          @identifier_type = identifier['identifier_type']
          @identifier_value = identifier['identifier_value']
        end
        super
      end
    end
  end
end