module Cdm
  module Messaging
    class OrganisationAddress < MessageMapper
      include AttributeMapper
      attribute_name :address

      def value(object, *)
        object.address.join(' ')
      end
    end
  end
end