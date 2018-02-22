# Endpoint for organisationType message element. For the CDM model this maps to an enumerated type, so the message
# :organisationType becomes a lookup in the organisationType enumeration in config/schemas/enumeration.json
module Cdm
  module Messaging
    class OrganisationType < EnumerationMapper
    end
  end
end