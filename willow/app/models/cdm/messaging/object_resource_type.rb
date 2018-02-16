# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectResourceType
      class << self
        def call(object)
          { objectResourceType: '' }
        end
      end
    end
  end
end