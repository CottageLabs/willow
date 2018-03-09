module Cdm
  module Messaging
    class FileCompositionLevel < MessageMapper
      def value(object, _)
        object.compression.first
      end
    end
  end
end
