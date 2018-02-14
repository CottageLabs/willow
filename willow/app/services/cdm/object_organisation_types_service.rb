module Cdm
  class ObjectOrganisationTypesService < ServicesBase
    class << self
      def authority_name
        'rdss_organisation_types'
      end

      def internationalisation_root
        'rdss.organisation_types.'
      end
    end
  end
end
