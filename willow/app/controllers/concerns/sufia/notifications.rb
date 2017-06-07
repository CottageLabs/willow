module Sufia
  module Notifications
    extend ActiveSupport::Concern

    included do
      def after_create_response
        logger.info('AFTER CREATE RESPONSE222')
        super
      end

    end


  end
end
