module Cdm
  module Messaging
    class RightsStatement < MessageMapper
      def value(object, attribute)
        super.to_a
      end
    end
  end
end