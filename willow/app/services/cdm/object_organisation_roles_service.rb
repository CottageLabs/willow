module Cdm
  class ObjectOrganisationRolesService < ServicesBase
    class << self
      def authority_name
        'rdss_organisation_roles'
      end

      def internationalisation_root
        'rdss.organisation_roles.'
      end
    end
  end
end