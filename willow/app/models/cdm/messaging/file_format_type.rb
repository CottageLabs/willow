module Cdm
  module Messaging
    class FileFormatType < MessageMapper
      def value(object, _)
        object.format_label.first 
      end
    end
  end
end
