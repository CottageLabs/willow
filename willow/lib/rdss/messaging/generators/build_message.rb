module Rdss
  module Messaging
    module Generators
      class BuildMessage
        class << self
          def default
            {
              header_generator: ::Rdss::Messaging::Generators::GenerateHeader,
              body_generator: ::Rdss::Messaging::Generators::GenerateBody,
              error_checker: ::Rdss::Messaging::Schema::Validation
            }.freeze
          end

          def call(payload, event: :create, version: :current, header_generator: default[:header_generator], body_generator: default[:body_generator], error_checker: default[:error_checker])
            new(event: event, version: version, header_generator: header_generator, body_generator: body_generator, error_checker: error_checker).call(payload)
          end
        end

        private

        attr_reader :version, :event, :body, :header_generator, :body_generator, :error_checker

        def initialize(version: :current, event: :create, header_generator: self.default[:header_generator], body_generator: self.default[:body_generator], error_checker: self.default[:error_checker])
          @event = event
          @version = version
          @header_generator = header_generator
          @body_generator = body_generator
          @error_checker = error_checker
        end

        def to_message(errors)
          {
            messageHeader: header_generator.(version: version, event: event, errors: errors),
            messageBody: @body
          }
        end

        def body(payload)
          body_generator.(payload, version: version, event: event)
        end

        public

        def call(payload)
          @body=body(payload)
          to_message(error_checker.(body: @body, event: event, version: version))
        end
      end
    end
  end
end
