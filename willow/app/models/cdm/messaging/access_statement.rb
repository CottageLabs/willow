# Endpoint for access message element. For the CDM model this maps to has_many :accesses, so the message
# :access translates to the attribute :accesses in the CDM

module Cdm
  module Messaging
    class AccessStatement < MessageMapper
      def value(object, _)
        object.access_statement || I18n.t("rdss.access_types.#{object.access_type}")
      end
    end
  end
end