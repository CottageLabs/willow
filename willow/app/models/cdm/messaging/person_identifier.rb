# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonIdentifier < MessageMapper
      def array_value(*)
        [
          {
            personIdentifierType: 1,
            personIdentifierValue: 'deprecated'
          }
        ]
      end
    end
  end
end