module Cdm
  module Messaging
    class FileName < MessageMapper
      def value(object, _)
        object.file_name.first
      end
    end
  end
end
