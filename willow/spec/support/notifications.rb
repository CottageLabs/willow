require 'rails_helper'

def notification_message_for(event)
  message = nil
  subscription = ActiveSupport::Notifications.subscribe(event) do |event, start, finish, id, payload|
    message = payload
  end

  yield

  ActiveSupport::Notifications.unsubscribe(subscription)

  message
end