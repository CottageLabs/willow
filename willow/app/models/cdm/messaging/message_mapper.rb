# This is the root of the message mapping system. The inputs to the class level call entrypoint are the root name,
# a message format map describing the fields in the message (not required or optional as of yet), and the object to
# operate on.
# The system then will walk down the tree, reducing and aggregating as required using external classes, which will
# either inherit from this one or one of its subclasses.
#
# messaging attributes can have one of three values:
#   = Array     -> call the corresponding collection attribute in the object and turn the return into an array which is
#                  used to map further for each child object using the next stage of the map
#   = Hash      -> use the hash keys to further reduce the next set of attributes for the map
#   = Nil/Other -> This is an actual endpoint so call the value(object, attribute_name) for it (Note that the attribute
#                  name can be overridden by including the AttributeMapper class in the subclass and telling it which
#                  attribute to use for the object)
#
# Note that there was a conscious decision to keep all three of these types together in one class so that different
# types of maps could be used for messaging. Attribute mapping classes can do all three (hash, array or other) overrides
# depending on how those maps look.
#
# TODO: Update the message map to ensure that required and optional fields are handled appropriately.
module Cdm
  module Messaging
    class MessageMapper
      attr_reader :name
      class << self
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
      end

      def initialize(name)
        @name=name
      end

      def attribute_name
        name.to_s.underscore.downcase
      end

      def decode_message_map(message_map, object)
        case message_map
          when Hash
            hash_value(message_map, object)
          when Array
            array_value(message_map, object)
          when NilClass
            value(object, attribute_name)
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
          object.send(attribute_name).map do |item|
            decoder.nil? ? value(object, nil) : decode_message_map(decoder, item)
          end
        end.flatten
      end

      def value(object, override_name=nil)
        override_name && object.send(override_name) || object.send(attribute_name)
      end
    end
  end
end