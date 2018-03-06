module Cdm
  module Messaging
    class RightsHolder < MessageMapper
      def array_value(_, object)
        object.rights_holder.to_a
      end
    end
  end
end