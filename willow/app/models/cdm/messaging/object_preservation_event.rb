module Cdm
  module Messaging
    class ObjectPreservationEvent < MessageMapper
      def hash_value(message_map, object)
        {
          preservationEventValue: 'default value',
          preservationEventType: Enumerations::PreservationEventType.creation,
          preservationEventDetail: 'default value'
        }
        ''
      end
    end
  end
end