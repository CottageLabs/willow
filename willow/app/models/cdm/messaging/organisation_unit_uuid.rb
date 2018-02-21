module Cdm
  module Messaging
    class OrganisationUnitUuid < MessageMapper
      include AttributeMapper
      attribute_name :id
    end
  end
end