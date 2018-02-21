module Cdm
  module Messaging
    class PersonSn < MessageMapper
      include AttributeMapper
      attribute_name :family_name
    end
  end
end