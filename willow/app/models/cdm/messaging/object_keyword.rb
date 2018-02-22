# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectKeyword < MessageMapper
      include AttributeMapper
      attribute_name :object_keywords

      def value(object, attribute)
        super.to_a
      end
    end
  end
end