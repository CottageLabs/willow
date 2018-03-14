module Cdm
  module Messaging
    class FileDateCreated < MessageMapper
      private
      def candidate_regexen
        %w(
          %Y:%m:%d %H:%M:%S%Z
          %Y:%m:%d %H:%M:%S
          %Y:%m:%d
          %Y:%m
          %Y
        )
      end


      def rfc3339_value_from_fits_date(date_value)
        candidate_regexen.each do |format|
          begin
            return DateTime.strptime(date_value, format).rfc3339
          rescue ArgumentError
            next
          rescue TypeError
            break
          end
        end
        Time.at(0).rfc3339
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
