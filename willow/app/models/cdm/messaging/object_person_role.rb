module Cdm
  module Messaging
    class ObjectPersonRole < MessageMapper
      class << self
        def switch_person_and_role(mapping, object)
          object.object_people.map do |person|
            person.object_person_roles.map do |role|
              ::Cdm::Messaging::Person.(:person, mapping.first['person'], person).merge({ role: Enumerations::PersonRole.send(role.role_type) })
            end
          end.flatten
        end

        def call(name, mapping, object)
          { name=>switch_person_and_role(mapping, object) }
        end
      end
    end
  end
end