module Cdm
  module Messaging
    class ObjectUuid
      class << self
        def call(object)
          { objectUuid: object.uuid }
        end
      end
    end
  end
end