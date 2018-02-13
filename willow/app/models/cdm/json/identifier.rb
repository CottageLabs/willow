module Cdm
  module Json
    class Identifier < ::Cdm::Json::ModelBase
      attr_reader :type, :value
      def initialize(values={})
        @type=values['identifier_type']
        @value=values['identifier_value']
        super
      end
    end
  end
end