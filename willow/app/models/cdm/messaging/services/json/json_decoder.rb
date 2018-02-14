module Cdm
  module Messaging
    module Services
      module Json
        class JsonDecoder
          attr_accessor :json_string
          class << self
            def call(section, json_string)
              new(json_string).call(section)
            end
          end

          def initialize(json_string)
            @json_string=JSON.parse(json_string)
          end

          def call(section)
            @json_string['definitions'][section]
          end
        end
      end
    end
  end
end