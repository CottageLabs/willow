# This class is an extension to MessageMapper to set an empty string as the endpoint for the message.

module Cdm
  module Messaging
    class DefaultMapper < MessageMapper
      def hash_value(*)
        {}
      end

      def array_value(*)
        []
      end

      def value(object, *)
        ''
      end
    end
  end
end