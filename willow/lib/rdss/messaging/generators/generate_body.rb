module Rdss
  module Messaging
    module Generators
      class GenerateBody
        class << self
          def call(payload:, version: :current, event: :create, builder: ::Cdm::Messaging::RdssCdm)
            new(event: event, version: version).call(payload: payload, builder: builder)
          end
        end

        attr_reader :version, :event
        private
        def initialize(event: :create, version: :current)
          @version=version
          @event=event
        end

        def call(payload:, builder: ::Cdm::Messaging::RdssCdm)
          builder.(payload: payload, event: event, version: version)
        end
      end
    end
  end
end
