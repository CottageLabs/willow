module Cdm
  module Messaging
    class FileUse < MessageMapper
      def value(object)
        Enumerations::FileUse.original_file
      end
    end
  end
end
