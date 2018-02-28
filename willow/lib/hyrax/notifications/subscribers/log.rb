module Hyrax
  module Notifications
    module Subscribers
      class Log < Subscriber
        def notify(event, start, finish, id, payload)
          Rails.logger.info("Logging Hyrax event: #{BuildMessage.(payload)}")
        end
      end
    end
  end
end
