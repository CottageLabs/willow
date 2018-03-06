# Endpoint for objectCategory attribute which is :object_category in the rdss_cdm object
module Cdm
  module Messaging
    class ObjectCategory < MessageMapper
      def array_value(_, object)
        value(object).to_a
      end
    end
  end
end