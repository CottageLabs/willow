# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectKeyword
      class << self
        def call(object)
          { objectKeywords: '' }
        end
      end
    end
  end
end