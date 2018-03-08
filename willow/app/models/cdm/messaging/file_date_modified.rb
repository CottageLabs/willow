module Cdm
  module Messaging
    class FileDateModified < MessageMapper
      include AttributeMapper
      attribute_name :date_modified
    end
  end
end