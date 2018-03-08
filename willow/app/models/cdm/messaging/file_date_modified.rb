module Cdm
  module Messaging
    class FileDateModified < MessageMapper
      def array_value(_, object)
        [{
          dateType: Enumerations::DateType.modified,
          dateValue: object.date_modified.rfc3339
        }]
      end
    end
  end
end