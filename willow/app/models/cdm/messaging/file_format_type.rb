module Cdm
  module Messaging
    class FileFormatType < MessageMapper
      include AttributeMapper
      attribute_name :format_label
    end
  end
end