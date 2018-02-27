# Endpoint for organisationJiscId message element. This is called :jisc_id in the model.
module Cdm
  module Messaging
    class OrganisationJiscId < MessageMapper
      include AttributeMapper
      attribute_name :jisc_id

      def value(object, *)
        object.jisc_id.to_i
      end
    end
  end
end