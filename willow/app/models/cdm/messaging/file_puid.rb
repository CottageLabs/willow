module Cdm
  module Messaging
    class FilePuid < MessageMapper
      def array_value(_, object)
        []
      end
    end
  end
end