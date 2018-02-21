module Cdm
  module Messaging
    class RightsHolder < MessageMapper
      def value(object, attribute)
        super.to_a
      end
    end
  end
end