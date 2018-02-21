# The form only specifies the drop down for the licenceIdentifier, so there is a translation table in the locales
# section that keys of a normalised version of the url. That is a version with all non-alphanumeric characters replaced
# by underscores. There is an edge case where two of those could collide, but this is very unlikely, since none of the
# licences use '_' as a separator between characters.
#
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