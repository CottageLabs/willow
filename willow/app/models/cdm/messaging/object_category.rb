# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectCategory
      class << self
        def call(object)
          { objectCategory: '' }
        end
      end
    end
  end
end