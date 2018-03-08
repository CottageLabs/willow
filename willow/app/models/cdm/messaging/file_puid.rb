module Cdm
  module Messaging
    class FileDateModified < MessageMapper
      def array_value(_, object)
        []
      end
    end
  end
end