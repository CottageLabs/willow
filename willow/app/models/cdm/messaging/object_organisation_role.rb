# In the message map, both organisation and person have roles, which have the same 'role' attribute name.
# Since the organisation role is also mapped as a 'belongs_to' relationship, the linking of the attributes is
# slightly different, so the object_organisation_role map is overridden as an array of the form
# object_organisation_role: [{
#   organisation: { <organisation attributes> }
#   role: <integer>
# }]

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