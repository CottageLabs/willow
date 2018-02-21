# Endpoint for objectDate message attribute. For the CDM model this maps to has_many :object_dates, so the message
# :objectDate translates to the attribute :object_dates in the CDM
module Cdm
  module Messaging
    class ObjectDate < MessageMapper
      include AttributeMapper
      attribute_name :object_dates
    end
  end
end