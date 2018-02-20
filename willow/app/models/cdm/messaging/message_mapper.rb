module Cdm
  module Messaging
    class MessageMapper
      attr_reader :name
      class << self
        attr_accessor :attribute_name_in_model

        def call(name, message_map, object)
          new(name).(message_map, object)
        end

        def messaging_class(class_name)
          begin
            "::Cdm::Messaging::#{class_name}".constantize
          rescue NameError=>e
            ::Cdm::Messaging::MessageMapper
          end
        end

        def attribute_name(name)
          @attribute_name_in_model=name
        end
      end

      def initialize(name)
        @name=name
        self.class.attribute_name_in_model||=name.to_s.underscore.downcase
      end

      def decode_message_map(message_map, object)
        case message_map
          when Hash
            hash_value(message_map, object)
          when Array
            array_value(message_map, object)
          when NilClass
            value(object, self.class.attribute_name_in_model)
          else
            value(object, message_map.to_s.underscore.downcase)
        end
      end

      def call(message_map, object)
        { name.intern=>decode_message_map(message_map, object) }
      end

      def hash_value(message_map, object)
        message_map.keys.reduce({}) do |master, decoder|
          master.update(self.class.messaging_class(decoder.to_s.classify).(decoder, message_map[decoder], object))
        end
      end

      def array_value(message_map, object)
        message_map.map do |decoder|
          object.send(self.class.attribute_name_in_model).map do |item|
            decoder.nil? ? value(object) : decode_message_map(decoder, item)
          end
        end.flatten
      end

      def value(object, attribute_name=nil)
        attribute_name && object.send(attribute_name) || object.send(self.class.attribute_name_in_model)
      end
    end
  end
end