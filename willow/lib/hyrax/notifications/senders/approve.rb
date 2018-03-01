module Hyrax
  module Notifications
    module Senders
      class Approve
        class << self
          def call(target:, **)
            # When an item is approved, send the appropriate metadata message depending on whether it has been previously
            # deposited.
            ActiveSupport::Notifications.instrument(::Hyrax::Notifications::Events::METADATA_CREATE, target)
            true # important to return true here
          end
        end
      end
    end
  end
end
