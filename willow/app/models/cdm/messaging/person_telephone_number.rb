# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonTelephoneNumber < EmptyMapper
      def value(object, *)
        '1'
      end
    end
  end
end