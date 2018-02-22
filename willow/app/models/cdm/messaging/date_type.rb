# Endpoint for dateType message element. For the CDM model this maps to an enumerated type, so the message
# :dateType becomes a lookup in the dateType enumeration in config/schemas/enumeration.json

module Cdm
  module Messaging
    class DateType < EnumerationMapper
    end
  end
end