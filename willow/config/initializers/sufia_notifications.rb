require_dependency Rails.root.join('lib/sufia/notifications/subscribers/rails_log.rb')

Sufia::Notifications::Subscribers::RailsLog.register
