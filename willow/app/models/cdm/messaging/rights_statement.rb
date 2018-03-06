module Cdm
  module Messaging
    class RightsStatement < MessageMapper
      def array_value(_, object)
        object.rights_statement.to_a
      end
    end
  end
end