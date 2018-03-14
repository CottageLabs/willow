module Cdm
  module Messaging
    class FileDateCreated < MessageMapper
      public
      def hash_value(_, object)
        {
          dateType: Enumerations::DateType.created,
          dateValue: FitsToRfc3339.(object.original_file.date_created.first)
        }
      end
    end
  end
end
