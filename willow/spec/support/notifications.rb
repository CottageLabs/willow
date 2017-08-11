require 'rails_helper'

def notification_message_for(event)
  message = nil
  subscription = ActiveSupport::Notifications.subscribe(event) do |event, start, finish, id, payload|
    message = Hyrax::Notifications::Subscribers::BuildMessage.new(event, payload).to_message
  end

  yield

  ActiveSupport::Notifications.unsubscribe(subscription)

  return message
end