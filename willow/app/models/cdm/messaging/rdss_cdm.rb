require 'yaml_config'
module Cdm
  module Messaging
    class RdssCdm < MessageMapper
      include YAMLConfig
      config_directories etc: ["#{Rails.root}/config"]
      static_config_files :metadata_request

      class << self
        public
        def call(object)
          super(self.name.demodulize, metadata_request, object).values.first
        end
      end
    end
  end
end
