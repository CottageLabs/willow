# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectValue
      class << self
        def call(object)
          { objectValue: '' }
        end
      end
    end
  end
end