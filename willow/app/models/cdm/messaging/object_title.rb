module Cdm
  module Messaging
    class ObjectTitle < MessageMapper
      include AttributeMapper
      attribute_name :title
    end
  end
end