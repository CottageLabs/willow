module Concerns
  module RelationArrayMapper
    extend ActiveSupport::Concern

    class_methods do
      # We need to call '.to_a' on certain objects to force them
      # to resolve.  Otherwise in the form, the fields don't
      # display, for example, the object_dates' type and value
      # Instead they display something like:
      # '#<ActiveTriples::Relation:0x007fb564969c88>'
      def mapped_arrays(*names)
        names.each do |name|
          define_method name do
            convert_value_to_array(model.send(name))
          end
        end
      end
    end

    included do
      public # expose these to allow for them to be chained externally if required.
      def built_value(value)
        value.build && value
      end

      def build_if_blank(value)
        value.presence || built_value(value)
      end

      def convert_value_to_array(value)
        build_if_blank(value).to_a
      end
    end
  end
end