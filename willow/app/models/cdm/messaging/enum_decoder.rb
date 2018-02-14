module Cdm
  module Messaging
    class EnumDecoder
      class << self
        def types
          {
            :file=>::Cdm::Messaging::Services::FileBasedEnumDecoder,
            :api=>::Cdm::Messaging::Services::ApiBasedEnumDecoder
          }
        end

        def call(section, type=:file)
          types[type].(section).each_with_index do |object, index |
            define_singleton_method(object.underscore.downcase.intern) { (index+1).to_s }
          end
          self
        end

        def build_classes(type=:file)
          types[type].sections.each do |section|
            ::Cdm::Messaging.const_set(section.underscore.downcase.classify)
          end
        end
      end
    end
  end
end
