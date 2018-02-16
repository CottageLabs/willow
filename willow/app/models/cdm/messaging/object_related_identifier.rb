# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectRelatedIdentifier
      class << self
        def call(object)
          { objectRelatedIdentifier: '' }
        end
      end
    end
  end
end