module Cdm
  module Messaging
    class PersonIdentifier < MessageMapper
      def call(mapping, object)
        {
          personIdentifierValue: 'blackratprime',
          personIdentifierType: 3
        }
      end
    end
  end
end