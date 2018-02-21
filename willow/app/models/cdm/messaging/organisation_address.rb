# Endpoint for organisationAddress. The predicate used in the model has forced this to be a multiple:true.
# TODO Determine if multiple:true and the predicate are correct in this instance.
# The model attribute is just :address.
module Cdm
  module Messaging
    class OrganisationAddress < MessageMapper
      include AttributeMapper
      attribute_name :address

      def value(object, attribute)
        super.join(' ')
      end
    end
  end
end