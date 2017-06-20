module Sufia
  module Notifications
    module Subscribers
      class RailsLog

        def self.register(events: ['create_work.sufia', 'update_work.sufia', 'destroy_work.sufia'])

          Rails.logger.info("Subscribing RailsLog to Sufia events: #{events}")

          events.each do |event|
            ActiveSupport::Notifications.subscribe event do |*args|
              Rails.logger.info("Sufia event received: #{args.first}")
              Rails.logger.info(args)
            end
          end

        end

      end
    end
  end
end
