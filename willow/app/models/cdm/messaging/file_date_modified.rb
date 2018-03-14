module Cdm
  module Messaging
    class FileDateModified < MessageMapper
      def hash_value(_, object)
        {
          dateType: Enumerations::DateType.modified,
          # Default timestamp until JSON Schema is updated. 
          dateValue: object&.date_modified&.rfc3339 || Time.at(0).rfc3339
        }
      end

      def array_value(_, object)
        [
          hash_value(_, object)
        ]
      end

      def value(object, _)
        array_value(_, object)
      end
    end
  end
end
