module Cdm
  module Messaging
    class PersonGivenName < MessageMapper
      include AttributeMapper
      attribute_name :given_name
    end
  end
end