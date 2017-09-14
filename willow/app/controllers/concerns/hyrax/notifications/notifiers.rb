module Hyrax
  module Notifications
    module Notifiers
      extend ActiveSupport::Concern
      included do

        # no after_create_response here as the "create" event should be handled only after the item has been approved

        def after_update_response
          ActiveSupport::Notifications.instrument("MetadataUpdate", {curation_concern_type: self.class.curation_concern_type, object: curation_concern})
          super
        end

        def after_destroy_response(title)
          ActiveSupport::Notifications.instrument("MetadataDelete", {curation_concern_type: self.class.curation_concern_type, object: curation_concern})
          super
        end

      end
    end
  end
end
