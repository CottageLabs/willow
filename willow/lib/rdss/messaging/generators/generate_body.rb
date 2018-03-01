module Rdss
  module Messaging
    module Generators
      class GenerateBody
        class << self
          def call(object, version: :current, event: :create, builder: ::Cdm::Messaging::RdssCdm)
            new(event: event, version: version).call(object, builder: builder)
          end
        end

        attr_reader :version, :event
        private
        def initialize(event: :create, version: :current)
          @version=version
          @event=event
        end

        public
        def call(object, builder: ::Cdm::Messaging::RdssCdm)
          builder.(object, event: event, version: version)
        end
      end
    end
  end
end
