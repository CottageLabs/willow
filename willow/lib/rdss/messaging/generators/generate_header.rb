# TODO This is all wrong, but it's putting something into the header which is valid. Once we get past the happy
# path on this one, we need to add in error messages etc from a schema validation
module Rdss
  module Messaging
    module Generators
      class GenerateHeader
        class << self
          def call(event: :create, version: :current, errors: [])
            new(event: event, version: version).call(errors: errors)
          end
        end

        private
        def initialize(event: :create, version: :current)
          @event=event
          @version=version
        end

        def default_version
          version_map['2.0.0']
        end

        def version_map
          {
            current: '2.0.1-SNAPSHOT',
            '2.0.1': '2.0.1-SNAPSHOT',
            '2.0.0': '2.0.0-SNAPSHOT'
          }
        end

        def decode_errors(errors)
          {
            errorDescription: errors.join('; '),
            errorCode: 'GENERR001'
          }
        end

        def call(errors:)
          {
            messageId: ::SecureRandom.uuid,
            messageClass: 'Event',
            messageType: "Metadata#{event.camelize}",
            messageTimings: { publishedTimestamp: DateTime.now.rfc3339 },
            messageSequence: { sequence:SecureRandom.uuid,
                               position: 1,
                               total: 1
            },
            version: version_map[version]||default_version
          }.tap{|x| x.merge(decode_errors(errors)) if errors.present? }
        end
      end
    end
  end
end
