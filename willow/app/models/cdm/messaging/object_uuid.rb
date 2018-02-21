# Endpoint for objectUuid message element. This is called :id in the model.
module Cdm
  module Messaging
    class ObjectUuid < MessageMapper
      include AttributeMapper
      attribute_name :id
    end
  end
end