require 'securerandom'

module Hyrax
  module Notifications
    module Subscribers
      class BuildMessage
        include Hyrax::Engine.routes.url_helpers

        private
        def initialize(event, payload)
          @event = event
          @object = payload[:object]
        end

        def event_shortname
          @event=~/Metadata(.*)/
          $1.underscore.downcase.intern
        end

        def header()
          errors=JSON::Validator.validate()
          ::Rdss::Messaging::Header.()
        end

        def body
          ::Cdm::Messaging::RdssCdm.(@object, event_shortname)
        end

        public
        def to_message
          {
            messageHeader: header,
            messageBody: body
          }
        end
      end
    end
  end
end
