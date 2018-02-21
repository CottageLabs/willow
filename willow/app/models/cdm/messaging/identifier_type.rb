# Endpoint for identifierType message element. For the CDM model this maps to an enumerated type, so the message
# :identifierType becomes a lookup in the identifierType enumeration in config/schemas/enumeration.json

module Cdm
  module Messaging
    class IdentifierType < EnumerationMapper
    end
  end
end