module Cdm
  module Messaging
    class FileUploadStatus < MessageMapper
      def value(object)
        Enumerations::UploadStatus.upload_complete
      end
    end
  end
end
