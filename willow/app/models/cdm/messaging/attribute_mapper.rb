# Attribute mapper. Including this concern allows a messaging endpoint to call an attribute with an alternative name
# to its own. For example, in the following class:
#
# class ObjectName < MessageMapper
#   include AttributeMapper
#   attribute_name :name
# end
#
# would mean that instead of calling :object_name as the attribute on a passed object, :name would be called instead.

module Cdm
  module Messaging
    module AttributeMapper
      extend ActiveSupport::Concern

      class_methods do
        attr_accessor :attribute_name_in_model

        def attribute_name(name)
          @attribute_name_in_model=name
        end
      end

      included do
        def initialize(name)
          self.class.attribute_name_in_model||=name.to_s.underscore.downcase.intern
          super
        end

        def attribute_name
          self.class.attribute_name_in_model
        end
      end
    end
  end
end