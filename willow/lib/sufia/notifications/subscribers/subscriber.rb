module Sufia
  module Notifications
    module Subscribers
      class Subscriber

        def self.register(events: ['create_work.sufia', 'update_work.sufia', 'destroy_work.sufia'])
          @subscriber = self.new().subscribe(events)
        end

        def subscribe(events)
          Rails.logger.info("Subscribing #{self.class} to Sufia events: #{events}")
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
