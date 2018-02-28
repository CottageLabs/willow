# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonEntitlement < EmptyMapper
      def array_value(*)
        [1]
      end
    end
  end
end