module Cdm
  module Messaging
    class FileStorageStatus < MessageMapper
      def value(object)
        Enumerations::StorageStatus.online
      end
    end
  end
end
