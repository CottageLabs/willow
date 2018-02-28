# Endpoint for :personCn. This is mapped to :given_name in the CDM.
module Cdm
  module Messaging
    class PersonCn < MessageMapper
      include AttributeMapper
      attribute_name :display_name
    end
  end
end