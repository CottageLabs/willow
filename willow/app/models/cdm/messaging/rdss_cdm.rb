#Entrypoint for the RdssCdm message generation. The structure of the message map is read from the 'metatdata_request.yml'
# file in config, and this class is called with an object with a structure on the RdssCdm model.

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
          super(:payload, metadata_request, object)
        end
      end
    end
  end
end
