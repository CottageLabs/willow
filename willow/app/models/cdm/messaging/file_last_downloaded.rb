module Cdm
  module Messaging
    class FileLastDownloaded < MessageMapper
      def hash_value(_, object)
        {
          dateType: Enumerations::DateType.issued,
          dateValue: begin FileDownloadStat.where(file_id: object.original_file.id).first.downloads rescue "0" end
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
