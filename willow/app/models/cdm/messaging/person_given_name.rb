# Endpoint for :personGivenName. This is mapped to :given_name in the CDM.

module Cdm
  module Messaging
    class PersonGivenName < MessageMapper
      include AttributeMapper
      attribute_name :given_name
    end
  end
end