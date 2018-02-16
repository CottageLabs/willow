module Cdm
  module Messaging
    class ObjectPersonRole
      class << self
        def call(object)
          object.people.map do |person|
            person.object_person_roles.map do |role|
              {
                person: Person.(person),
                role: Enumerations::PersonRole.(role)
              }
            end
          end.flatten
        end
      end
    end
  end
end