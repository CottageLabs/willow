require 'securerandom'

module Sufia
  module Notifications
    module Subscribers
      class BuildMessage

        def initialize(event, payload)
          @event = event
          @payload = payload
        end

        def to_message
          return {
              messageHeader: {
                  messageId: SecureRandom.uuid,
                  messageClass: 'Event',
                  messageType: messageType,
                  messageTimings: {
                      publishedTimestamp: DateTime.now.rfc3339
                  },
                  messageSequence: {
                      sequence:SecureRandom.uuid,
                      position: 1,
                      total: 1
                  },
                  version: '0.0.1-SNAPSHOT'
              },
              messageBody: {
                payload: 'Hello World',
                event: @event,
                title: @payload[:object][:title],
                depositor: @payload[:object][:depositor],
                id: @payload[:object].id
              }

          }
        end

        private
        def messageType
          case @event
            when 'create_work.sufia'
              'CREATE'
            when 'update_work.sufia'
              'UPDATE'
            when 'delete_work.sufia'
              'DELETE'
            else
              "UNKNOWN-#{@event}"
          end
        end

      end
    end
  end
end
