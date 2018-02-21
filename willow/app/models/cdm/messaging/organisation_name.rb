# Endpoint for organisationName message element. This is called :name in the model.
module Cdm
  module Messaging
    class OrganisationName < MessageMapper
      include AttributeMapper
      attribute_name :name
    end
  end
end