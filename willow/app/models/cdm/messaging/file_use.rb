module Cdm
  module Messaging
    class FileUse < MessageMapper
      def value(object, _)
        Enumerations::FileUse.original_file
      end
    end
  end
end
