module Cdm
  module Messaging
    class ObjectFile
      class << self
        def call(object)
          { objectFile: '' }
        end
      end
    end
  end
end