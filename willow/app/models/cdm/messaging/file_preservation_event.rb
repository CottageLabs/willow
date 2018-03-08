module Cdm
  module Messaging
    class FilePreservationEvent < MessageMapper
      include AttributeMapper
      def hash_value(message_map, object)
        {
          preservationEventValue: 'not yet implemented', 
          preservationEventType: Enumerations::PreservationEventType.creation,
          preservationEventDetail: 'not yet implemented'
        }
      end
    end
  end
end
