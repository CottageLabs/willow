module Cdm
  module Messaging
    class FileDateCreated < MessageMapper
      private
      def rfc3339_value_from_fits_date(date_value)
        date_value.present? ? DateTime.strptime(date_value, "%Y:%m:%d %H:%M:%S%Z").rfc3339 : ''
      end

      public
      def hash_value(_, object)
        {
          dateType: Enumerations::DateType.created,
          dateValue: rfc3339_value_from_fits_date(object.original_file.date_created.first)
        }
      end
    end
  end
end