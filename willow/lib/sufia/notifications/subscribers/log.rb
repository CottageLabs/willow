module Sufia
  module Notifications
    module Subscribers
      class Log < Subscriber

        def notify(event, start, finish, id, payload)
          Rails.logger.info("Logging Sufia event: #{BuildMessage.new(event, payload).to_message}")
        end

      end
    end
  end
end
