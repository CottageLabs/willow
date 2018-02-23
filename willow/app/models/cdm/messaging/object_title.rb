# Endpoint for objectTitle message element. This is called :title in the model.
module Cdm
  module Messaging
    class ObjectTitle < MessageMapper
      include AttributeMapper
      attribute_name :title
    end
  end
end