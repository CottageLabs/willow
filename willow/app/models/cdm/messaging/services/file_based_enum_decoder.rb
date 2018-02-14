require 'singleton'
module Cdm
  module Messaging
    module Services
      class FileBasedEnumDecoder
        include Singleton
        class << self
          def call(section)
            self.call(section)
          end
        end

        def initialize(filename="#{Rails.root.to_s}/config/rdss-message-api-enumeration.json")
          @__cache__=JSON.parse(File.read(filename))['definitions']
        end

        def call(section)
          @__cache__[section]
        end
      end
    end
  end
end
