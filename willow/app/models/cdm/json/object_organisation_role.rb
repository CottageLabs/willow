module Cdm
  module Json
    class ObjectOrganisationRole < ::Cdm::Json::ModelBase
      attr_reader :role
      def initialize(values={})
        @role=values['role'].underscore.downcase.intern
        super
      end
    end
  end
end