module Cdm
  module Messaging
    class FileStorageStatus < MessageMapper
      def value(object, _)
        Enumerations::StorageStatus.online
      end
    end
  end
end
