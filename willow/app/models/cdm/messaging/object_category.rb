# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectCategory < MessageMapper
      def value(object)
        object.object_category.to_a
      end
    end
  end
end