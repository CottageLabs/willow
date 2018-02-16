module Cdm
  module Messaging
    class Person
      class << self
        def call(object)
          {
            personUuid: object.id,
            personIdentifier: PersonIdentifier.(object),
            personEntitlement: PersonEntitlement.(object),
            personAffiliation: PersonAffiliation.(object),
            personGivenName: object.given_name,
            personCn: object.given_name,
            personSn: object.family_name,
            personTelephoneNumber: '',
            personMail: '',
            personOrganisationUnit: PersonOrganisationUnit.(object)
          }
        end
      end
    end
  end
end