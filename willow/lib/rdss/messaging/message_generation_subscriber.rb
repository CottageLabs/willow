module Rdss
  module Messaging
    class MessageGenerationSubscriber
      def message_builder(object, event:)
        Rdss::Messaging::Generators::BuildMessage.(object, event: event)
      end

      def work_approval(rdss_cdm)
        ActiveSupport::Notifications.instrument(::Hyrax::Notifications::Events::METADATA_CREATE, message_builder(rdss_cdm, event: :create))
      end

      def work_update_minor(rdss_cdm)
        ActiveSupport::Notifications.instrument(::Hyrax::Notifications::Events::METADATA_UPDATE, message_builder(rdss_cdm, event: :update))
      end

      def work_update_major(rdss_cdm)
        ActiveSupport::Notifications.instrument(::Hyrax::Notifications::Events::METADATA_CREATE, message_builder(rdss_cdm, event: :create))
      end

      def work_destroy(rdss_cdm)
        ActiveSupport::Notifications.instrument(::Hyrax::Notifications::Events::METADATA_DELETE, message_builder(rdss_cdm, event: :delete))
      end
    end
  end
end
