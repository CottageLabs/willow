# Endpoint for :personSn. This is mapped to :family_name in the CDM.

module Cdm
  module Messaging
    class PersonSn < MessageMapper
      include AttributeMapper
      attribute_name :family_name
    end
  end
end