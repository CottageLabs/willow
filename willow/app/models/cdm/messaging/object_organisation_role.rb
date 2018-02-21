module Cdm
  module Messaging
    class ObjectOrganisationRole < MessageMapper
      include AttributeMapper
      attribute_name :object_organisation_roles

      class << self
        def map_organisation_role(mapping, object)
          object.send(attribute_name_in_model).map do |oor|
            ::Cdm::Messaging::Organisation.(:organisation, mapping.first['organisation'], oor.organisation).merge({ role: ::Cdm::Messaging::Enumerations::OrganisationRole.send(oor.role) })
          end.flatten
        end

        def call(name, mapping, object)
          { name.intern=>map_organisation_role(mapping, object) }
        end
      end

    end
  end
end