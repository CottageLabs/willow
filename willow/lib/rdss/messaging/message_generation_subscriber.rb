module Rdss
  module Messaging
    class MessageGenerationSubscriber
      def work_approval(rdss_cdm)
        work_logger.info("Approved: #{rdss_cdm.id}")
      end

      def work_update_minor(rdss_cdm)
        work_logger.info("Minor Updated: #{rdss_cdm.id}")
      end

      def work_update_major(rdss_cdm)
        work_logger.info("Major Updated: #{rdss_cdm.id}")
      end

      def work_destroy(rdss_cdm)
        work_logger.info("Destroyed: #{rdss_cdm.id}")
      end

      private
        def work_logger
          @@work_logger ||= Logger.new("#{Rails.root}/log/message_listener.log")
        end
    end
  end
end
