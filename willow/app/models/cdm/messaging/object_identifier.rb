# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class ObjectIdentifier
      class << self
        def call(object)
          { objectIdentifier: '' }
        end
      end
    end
  end
end