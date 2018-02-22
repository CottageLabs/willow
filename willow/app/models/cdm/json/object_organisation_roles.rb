module Cdm
  module Json
    class ObjectOrganisationRoles
      attr_reader :roles
      delegate :map, :"[]", to: :roles

      def initialize(string)
        @roles = JSON.parse(string).map { |x| ::Cdm::Json::ObjectOrganisationRole.new(x) }
      end
    end
  end
end
