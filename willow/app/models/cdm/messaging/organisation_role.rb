# Endpoint for role (organisation) message element. For the CDM model this maps to an enumerated type, so the message
# :role becomes a lookup in the organisationRole enumeration in config/schemas/enumeration.json
# Note that this is explicitly called from the object_organisation_role as an override.

module Cdm
  module Messaging
    class OrganisationRole < EnumerationMapper
    end
  end
end