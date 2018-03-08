module Cdm
  module Messaging
    class FileChecksum < MessageMapper
      def hash_value(message_mapper, object)
        {
          checksumUuid: SecureRandom.uuid,
          checksumType: 'md5',
          checksumValue: object.original_file.original_checksum
        }
      end
    end
  end
end