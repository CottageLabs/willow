# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class Licence < MessageMapper
      def hash_value(_, object)
        {
          licenceName: object,
          licenceIdentifier: object
        }
      end
    end
  end
end