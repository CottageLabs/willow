module Cdm
  module Messaging
    class FileChecksum < MessageMapper
      def array_value(message_mapper, object)
        [{
          checksumUuid: object.checksum_uuid,
          checksumType: Enumerations::ChecksumType.md5,
          checksumValue: object.original_file.original_checksum
        }]
      end
    end
  end
end