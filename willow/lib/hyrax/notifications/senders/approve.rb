module Hyrax
  module Notifications
    module Senders
      module Approve
      extend ActiveSupport::Concern

        def self.call(target:, **)
          # When an item is approved, send the MetadataCreate message. Subsequent edits / deletes will be handled by
          # the controllers
          ActiveSupport::Notifications.instrument("MetadataCreate", {curation_concern_type: target.class, object: target})

          true # important to return true here
        end
      end
    end
  end
end
