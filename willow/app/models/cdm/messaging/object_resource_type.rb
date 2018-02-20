# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectResourceType < EnumerationMapper
      def mapper
        Enumerations::ResourceType
      end
    end
  end
end