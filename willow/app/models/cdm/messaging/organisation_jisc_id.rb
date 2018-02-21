module Cdm
  module Messaging
    class OrganisationJiscId < MessageMapper
      include AttributeMapper
      attribute_name :jisc_id
    end
  end
end