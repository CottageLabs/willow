# Endpoint for accessType message element. For the CDM model this maps to an enumerated type, so the message
# :accessType becomes a lookup in the accessType enumeration in config/schemas/enumeration.json

module Cdm
  module Messaging
    class AccessType < EnumerationMapper
    end
  end
end