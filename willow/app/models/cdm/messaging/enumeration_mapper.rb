# Note: In the messaging for some unknown reason, this is objectKeywords rather than objectKeyword.
module Cdm
  module Messaging
    class EnumerationMapper < MessageMapper
      def mapper
        Enumerations::const_get(self.class.name.demodulize)
      end

      def value(object, attribute)
        begin
          mapper.send(object.send(attribute).underscore.downcase)
        rescue Exception => e
          puts("Exception in decoding #{attribute} in #{self.class.name} for #{object}")
        end
      end
    end
  end
end