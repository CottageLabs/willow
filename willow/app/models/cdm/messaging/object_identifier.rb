# TODO: The messaging format and CDM don't quite match or make perfect sense for ObjectIdentifier and ObjectRelatedIdentifier
# The standard hashing is overridden to force a valid relation_type in here, even though it shouldn't be required for ObjectIdentifier
# and the hash_value method should be removed when the correct messaging map is applied.
module Cdm
  module Messaging
    class ObjectIdentifier < MessageMapper
      include AttributeMapper
      attribute_name :object_identifiers

      def hash_value(message_map, object)
        {
          identifierValue: object.identifier_value,
          identifierType: Enumerations::IdentifierType.send(object.identifier_type),
          relationType: Enumerations::RelationType.cites
        }
      end
    end
  end
end