module Cdm
  module Messaging
    class RightsStatement < MessageMapper
      def value(object)
        object.rights_statement.to_a
      end
    end
  end
end