module Cdm
  module Messaging
    class ObjectUuid < MessageMapper
      def values(object, *)
        object.object_uuid
      end
    end
  end
end