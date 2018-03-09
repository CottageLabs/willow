module Cdm
  module Messaging
    class FileCompositionLevel < MessageMapper
      include AttributeMapper
      attribute_name :compression
    end
  end
end