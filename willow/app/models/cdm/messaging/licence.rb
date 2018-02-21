# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class Licence < MessageMapper
      def normalize(object)
        object.tr('^a-zA-Z0-9','_')
      end

      def hash_value(_, object)
        {
          licenceName: I18n.t("rdss.licences.#{normalize(object)}"),
          licenceIdentifier: object
        }
      end
    end
  end
end