module Rdss
  module Messaging
    class MessageGenerationSubscriber

      def rdss_cdm_approved(rdss_cdm)
        work_logger.info("Approved: #{rdss_cdm.id}")
      end

      private
        def work_logger
          @@work_logger ||= Logger.new("#{Rails.root}/log/message_listener.log")
        end
    end
  end
end
