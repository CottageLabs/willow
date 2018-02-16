module Cdm
  module Messaging
    class ObjectDescription
      class << self
        def call(object)
          { objectDescription: object.description }
        end
      end
    end
  end
end