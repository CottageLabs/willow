module Cdm
  module Messaging
    class OrganisationName < MessageMapper
      include AttributeMapper
      attribute_name :name
    end
  end
end