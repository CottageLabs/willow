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
          self.class.attribute_name_in_model||=name.to_s.underscore.downsize.intern
          super
        end

        def attribute_name
          self.class.attribute_name_in_model
        end
      end
    end
  end
end