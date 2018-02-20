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