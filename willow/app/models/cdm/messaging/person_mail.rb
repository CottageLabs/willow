# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonMail < MessageMapper
      include AttributeMapper
      attribute_name :mail
    end
  end
end