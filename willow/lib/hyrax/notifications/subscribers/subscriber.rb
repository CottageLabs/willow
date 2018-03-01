module Hyrax
  module Notifications
    module Subscribers
      class Subscriber
        class << self
          def register(events: [Hyrax::Notifications::Events::METADATA_CREATE, Hyrax::Notifications::Events::METADATA_UPDATE, Hyrax::Notifications::Events::METADATA_DELETE])
            @subscriber = new.subscribe(events)
          end
        end

        def subscribe(events)
          Rails.logger.info("Subscribing #{self.class} to Hyrax events: #{events}")
          events.each do |event|
            ActiveSupport::Notifications.subscribe event do |event, start, finish, id, payload|
              notify(event, start, finish, id, payload)
            end
          end
          self
        end

        def notify(event, start, finish, id, payload)
          raise "implement in derived class"
        end

      end
    end
  end
end
