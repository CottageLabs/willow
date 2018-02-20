module Cdm
  module Messaging
    class RightsHolder < MessageMapper
      def value(object)
        object.rights_holder.to_a
      end
    end
  end
end