module Cdm
  module Messaging
    class Person < MessageMapper
      # class << self
      #   def call(object)
      #     {
      #       personUuid: object.id,
      #       personIdentifier: ::Cdm::Messaging::PersonIdentifier.(object),
      #       personEntitlement: ::Cdm::Messaging::PersonEntitlement.(object),
      #       personAffiliation: ::Cdm::Messaging::PersonAffiliation.(object),
      #       personGivenName: object.given_name,
      #       personCn: object.given_name,
      #       personSn: object.family_name,
      #       personTelephoneNumber: '',
      #       personMail: '',
      #       personOrganisationUnit: ::Cdm::Messaging::PersonOrganisationUnit.(object)
      #     }
      #   end
      # end
    end
  end
end