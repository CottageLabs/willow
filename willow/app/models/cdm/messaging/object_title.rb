module Cdm
  module Messaging
    class ObjectTitle
      class << self
        def call(object)
          { objectTitle: object.title.join('; ') }
        end
      end
    end
  end
end