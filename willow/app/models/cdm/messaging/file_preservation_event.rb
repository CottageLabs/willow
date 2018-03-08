module Cdm
  module Messaging
    class FilePreservationEvent < MessageMapper
      def hash_value(message_map, object)
        {
          preservationEventValue: 'not yet implemented', 
          preservationEventType: Enumerations::PreservationEventType.creation,
          preservationEventDetail: 'not yet implemented'
        }
      end

      def array_value(message_map, object)
        [
          hash_value(message_map, object)
        ]
      end
    end
  end
end
