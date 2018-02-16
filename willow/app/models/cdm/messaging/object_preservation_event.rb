module Cdm
  module Messaging
    class ObjectPreservationEvent
      class << self
        def call(object)
          { objectPreservationEvent: '' }
        end
      end
    end
  end
end