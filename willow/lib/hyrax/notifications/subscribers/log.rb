module Hyrax
  module Notifications
    module Subscribers
      class Log < Subscriber
        def notify(event, start, finish, id, message)
          Rails.logger.info("Logging Hyrax event: #{message}")
        end
      end
    end
  end
end
