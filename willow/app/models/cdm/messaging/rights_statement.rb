module Cdm
  module Messaging
    class RightsStatement
      class << self
        def call(object)
          { rightsStatement: object.rights_statements }
        end
      end
    end
  end
end