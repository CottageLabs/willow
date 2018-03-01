module Hyrax
  module Notifications
    module Notifiers
      extend ActiveSupport::Concern
      included do

        # no after_create_response here as the "create" event should be handled only after the item has been approved
        # def after_create_response
        #   ActiveSupport::Notifications.instrument(Events::METADATA_CREATE, {curation_concern_type: self.class.curation_concern_type, object: curation_concern})
        #   super
        # end

        def after_update_response
          # only send METADATA_UPDATE message if the object is active
          if curation_concern.state.id == 'http://fedora.info/definitions/1/0/access/ObjState#active'
            ActiveSupport::Notifications.instrument(Events::METADATA_UPDATE, {curation_concern_type: self.class.curation_concern_type, object: curation_concern})
          end
          super
        end

        def after_destroy_response(title)
          ActiveSupport::Notifications.instrument(Events::METADATA_DELETE, {curation_concern_type: self.class.curation_concern_type, object: curation_concern})
          super
        end

      end
    end
  end
end
