module Cdm
  module Messaging
    class FileUploadStatus < MessageMapper
      def value(object, _)
        Enumerations::UploadStatus.upload_complete
      end
    end
  end
end
