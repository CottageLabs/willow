# TODO This is all wrong, but it's putting something into the header which is valid. Once we get past the happy
# path on this one, we need to add in error messages etc from a schema validation
module Rdss
  module Messaging
    class Header
      class << self
        def call(error_class)
          {
            messageId: messageId,
            messageClass: messageClass,
            messageType: messageType,
            messageTimings: messageTimings,
            messageSequence: messageSequence,
            version: version
          }.merge(errors(error_class))
        end

        private
        def errors(error_class)
          error_class.nil? && {} || {

          }
        end

        ##########################
        # message header
        ##########################

        def messageId
          SecureRandom.uuid
        end

        def messageClass
          'Event'
        end

        def messageType
          @event
        end

        def messageTimings
          { publishedTimestamp: DateTime.now.rfc3339 }
        end

        def messageSequence
          {
            sequence:SecureRandom.uuid,
            position: 1,
            total: 1
          }
        end

        def version
          '0.0.1-SNAPSHOT'
        end
      end
    end
  end
end