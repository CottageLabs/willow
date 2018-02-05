module Cdm
  module Json
    class Access < ::Cdm::Json::ModelBase
      attr_reader :type, :statement
      def initialize(values={})
        @type=values['access_type']
        @statement=values['access_statement']
        super
      end
    end
  end
end