module Cdm
  module Messaging
    class FileChecksum < MessageMapper
      def hash_value(message_mapper, object)
        {
           checksumUuid: object.checksum_uuid,
           checksumType: Enumerations::ChecksumType.md5,
           checksumValue: object.original_file.original_checksum
        }
      end

      def array_value(message_mapper, object)
        [
          hash_value(message_mapper, object)
        ]
      end
    end
  end
end