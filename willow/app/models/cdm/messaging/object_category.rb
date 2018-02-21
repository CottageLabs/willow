# Endpoint for objectCategory attribute which is :object_category in the rdss_cdm object
module Cdm
  module Messaging
    class ObjectCategory < MessageMapper
      def value(object, attribute)
        super.to_a
      end
    end
  end
end