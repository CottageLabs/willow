module Cdm
  module Json
    class ObjectOrganisationRole < ::Cdm::Json::ModelBase
      attr_reader :role, :organisation
      def initialize(values = {})
        @role = values['role'].underscore.downcase.intern
        @organisation = ::Cdm::Json::Organisation.new(values['organisation'])
        super
      end
    end
  end
end
