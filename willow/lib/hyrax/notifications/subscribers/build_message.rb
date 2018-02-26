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

        public
        def to_message
          {
              messageHeader: ::Rdss::Messaging::Header.(),
              messageBody: ::Cdm::Messaging::RdssCdm.(@object, event_shortname)
          }
        end
      end
    end
  end
end
