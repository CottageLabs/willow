module Cdm
  module Messaging
    class Access < MessageMapper
      include AttributeMapper
      attribute_name :accesses
    end
  end
end