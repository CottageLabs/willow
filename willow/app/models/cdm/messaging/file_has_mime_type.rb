module Cdm
  module Messaging
    class FileHasMimeType < MessageMapper
      include AttributeMapper
      attribute_name :mime_type
    end
  end
end