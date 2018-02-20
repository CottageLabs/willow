module Cdm
  module Messaging
    class PersonAffiliation < MessageMapper
      def array_value(*)
        [1]
      end
    end
  end
end