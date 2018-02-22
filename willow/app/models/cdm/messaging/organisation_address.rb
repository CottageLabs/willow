# Endpoint for organisationAddress. The predicate used in the model has forced this to be a multiple:true.
# The model attribute is just :address.
module Cdm
  module Messaging
    class OrganisationAddress < MessageMapper
      include AttributeMapper
      attribute_name :address
    end
  end
end