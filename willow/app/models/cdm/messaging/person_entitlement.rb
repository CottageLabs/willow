module Cdm
  module Messaging
    class PersonEntitlement < MessageMapper
      def array_value(*)
        [1]
      end
    end
  end
end