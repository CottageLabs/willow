module Cdm
  module Messaging
    class ObjectUuid < MessageMapper
      include AttributeMapper
      attribute_name :id
    end
  end
end