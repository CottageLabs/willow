# Endpoint for objectResourceType message element. For the CDM model this maps to an enumerated type, so the message
# :objectResourceType becomes a lookup in the resourceType enumeration in config/schemas/enumeration.json.
# Note that the class names don't follow the normal mapping, so the mapper has been explicitly named as an override.
module Cdm
  module Messaging
    class ObjectResourceType < EnumerationMapper
      def mapper
        Enumerations::ResourceType
      end
    end
  end
end