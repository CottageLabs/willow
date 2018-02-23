# Endpoint for :personUuid. This is mapped to :id in the CDM.

module Cdm
  module Messaging
    class PersonUuid < MessageMapper
      include AttributeMapper
      attribute_name :id
    end
  end
end