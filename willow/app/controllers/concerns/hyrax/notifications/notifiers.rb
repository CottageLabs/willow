module Hyrax
  module Notifications
    module Notifiers
      extend ActiveSupport::Concern
      included do

        def after_create_response
          ActiveSupport::Notifications.instrument("create_work.hyrax", {curation_concern_type: self.class.curation_concern_type, object: curation_concern})
          super
        end

        def after_update_response
          ActiveSupport::Notifications.instrument("update_work.hyrax", {curation_concern_type: self.class.curation_concern_type, object: curation_concern})
          super
        end

        def after_destroy_response(title)
          ActiveSupport::Notifications.instrument("destroy_work.hyrax", {curation_concern_type: self.class.curation_concern_type, object: curation_concern})
          super
        end

      end
    end
  end
end
