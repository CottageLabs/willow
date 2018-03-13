module Cdm
  module Messaging
    class FileCompositionLevel < MessageMapper
      def value(object, _)
        (object.compression.first || 0).to_s
      end
    end
  end
end
