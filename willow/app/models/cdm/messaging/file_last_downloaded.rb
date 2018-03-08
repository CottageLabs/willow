module Cdm
  module Messaging
    class FileLastDownloaded < MessageMapper
      def hash_value(_, object)
        {
          dateType: Enumerations::DateType.published,
          dateValue: object.date_modified.rfc3339
        }
      end

      def array_value(_, object)
        [
          hash_value(_, object)
        ]
      end

    end
  end
end