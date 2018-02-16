module Cdm
  module Messaging
    class ObjectDate
      class << self
        def call(object)
          { objectDate: '' }
        end
      end
    end
  end
end