module Cdm
  module Messaging
    class RightsHolder
      class << self
        def call(object)
          { rightsHolder: object.rights_holders }
        end
      end
    end
  end
end