module Cdm
  module Messaging
    class ObjectFile < MessageMapper
      class << self
        def call(name, mapping, object)
          # TODO We're throwing this away for now. Fix once file is completed.
          {}
        end
      end
    end
  end
end