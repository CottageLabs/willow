module Cdm
  module Messaging
    class EnumDecoder
      class << self
        def types
          {
            :file=>::Messaging::Services::FileBasedEnumDecoder,
            :api=>::Messaging::Services::ApiBasedEnumDecoder
          }
        end

        def call(object, type=:file)
          types[type].new(object).call
        end
      end
    end
  end
end
