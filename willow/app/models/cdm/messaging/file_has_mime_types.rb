module Cdm
  module Messaging
    class FileFormatType < MessageMapper
      include AttributeMapper
      attribute_name :mime_type
    end
  end
end