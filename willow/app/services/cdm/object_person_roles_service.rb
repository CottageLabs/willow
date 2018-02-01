module Cdm
  class ObjectPersonRolesService < ServicesBase
    class << self
      def authority_name
        'rdss_person_roles'
      end

      def internationalisation_root
        'rdss.person_roles.'
      end

      def solr_prefix
        'object_person_role_'
      end
    end
  end
end