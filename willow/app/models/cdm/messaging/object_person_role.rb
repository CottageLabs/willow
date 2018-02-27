# In the message map, both organisation and person have roles, which have the same 'role' attribute name.
# Since the person and object_person_role are inverted to make it easier to display and render for the application,
# the translation from the message map requires that they are flattened and mapped as
# object_person_role: [{
#   person: { <person attributes> }
#   role: <integer>
# }]

module Cdm
  module Messaging
    class ObjectPersonRole < MessageMapper
      class << self
        def switch_person_and_role(mapping, object)
          object.object_people.map do |person|
            person.object_person_roles.map do |role|
              ::Cdm::Messaging::Person.(:person, mapping.first['person'], person).merge({ role: ::Cdm::Messaging::Enumerations::PersonRole.send(role.role_type) })
            end
          end.flatten
        end

        def call(name, mapping, object)
          { name.intern=>switch_person_and_role(mapping, object) }
        end
      end
    end

    PersonIdentifier = DefaultMapper
    PersonEntitlement = DefaultMapper
    PersonAffiliation = DefaultMapper
    PersonTelephoneNumber = DefaultMapper
    PersonMail = DefaultMapper
    PersonOrganisationUnit = DefaultMapper
  end
end