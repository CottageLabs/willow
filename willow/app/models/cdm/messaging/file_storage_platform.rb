module Cdm
  module Messaging
    class FileStoragePlatform < MessageMapper
      include AttributeMapper
      def hash_value(message_map, object)
        {
          storagePlatformUuid: '00000000-0000-0000-0000-000000000000',
          storagePlatformName: 'not yet implemented',
          storagePlatformType: Enumerations::StorageType.http,
          storagePlatformCost: 'not yet implemented'
        }
      end
    end
  end
end
