module Cdm
  module Messaging
    class FileDateCreated < MessageMapper
      def hash_value(_, object)
        {
          dateType: Enumerations::DateType.created,
          dateValue: DateTime.strptime(object.original_file.date_created.first, "%Y:%m:%d %H:%M:%S%Z").rfc3339
        }
      end
    end
  end
end