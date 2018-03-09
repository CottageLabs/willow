module Cdm
  module Messaging
    class FileSize < MessageMapper
      def value(object, _)
        object.file_size.first.to_i
      end
    end
  end
end
