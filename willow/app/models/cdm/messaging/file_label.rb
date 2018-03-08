module Cdm
  module Messaging
    class FileLabel < MessageMapper
      include AttributeMapper
      attribute_name :label
    end
  end
end