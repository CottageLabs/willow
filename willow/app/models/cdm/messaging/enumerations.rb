# The list of enumerated types. Note that this could have been automatically generated from the source file
# config/schemas/enumerations.json, but that would have tied us to the file at this level and the preference
# would be to move to an API call into the Taxonomy system at some point.
# The list corresponds to the sections in the enumeration file and creates a translation class for each of those
# by using the Enumerations::Decoder based on their position in the list.

module Cdm
  module Messaging
    module Enumerations
      %w(
        accessType
        checksumType
        dateType
        eduPersonScopedAffiliation
        fileUse
        identifierType
        messageClass
        objectValue
        organisationRole
        organisationType
        personIdentifierType
        personRole
        preservationEventType
        relationType
        resourceType
        storageStatus
        storageType
        uploadStatus
      ).each do |enum_section|
        ::Cdm::Messaging::Enumerations::const_set(enum_section.classify, Decoder.(enum_section))
      end
    end
  end
end