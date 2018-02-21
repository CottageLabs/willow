# Endpoint for access message element. For the CDM model this maps to has_many :accesses, so the message
# :access translates to the attribute :accesses in the CDM

module Cdm
  module Messaging
    class Access < MessageMapper
      include AttributeMapper
      attribute_name :accesses
    end
  end
end