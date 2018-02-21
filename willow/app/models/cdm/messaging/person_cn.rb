module Cdm
  module Messaging
    class PersonCn < MessageMapper
      include AttributeMapper
      attribute_name :given_name
    end
  end
end