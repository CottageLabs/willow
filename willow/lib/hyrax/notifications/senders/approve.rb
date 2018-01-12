module Hyrax
  module Notifications
    module Senders
      module Approve
      extend ActiveSupport::Concern

        def self.call(target:, **)
          # We'll maintain the later behaviour for other Work types, but skip it for the new type until 
          # the correct CRUD behaviour is implemented. 
          if target.instance_of? RdssCdm
            return true
          end

          # When an item is approved, send the appropriate metadata message depending on whether it has been previously
          # deposited.
          if target.import_url.present?
            ActiveSupport::Notifications.instrument(Events::METADATA_UPDATE, {curation_concern_type: target.class, object: target})
          else
            ActiveSupport::Notifications.instrument(Events::METADATA_CREATE, {curation_concern_type: target.class, object: target})
            target.update(import_url: 'true')
            # This is a bit of a bodge - but can't store this in Redis (not long-term persistent) and we shouldn't store
            # it in Fedora (as it is internal admin data, not strictly related to object). So in the database for now.
          end

          true # important to return true here
        end
      end
    end
  end
end
