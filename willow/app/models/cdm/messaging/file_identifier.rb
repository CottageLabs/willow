module Cdm
  module Messaging
    class FileIdentifier < MessageMapper
      include AttributeMapper
      attribute_name :id
    end
  end
end