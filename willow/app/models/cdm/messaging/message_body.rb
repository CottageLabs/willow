require 'blackrat_yaml_config'

module Cdm
  module Messaging
    class MessageBody
      class << self
        include YamlConfig
        static_config_files :metadata_request

        private
        def message_map
          @message_map = Yaml.load_file('config/')
        end

        def decoders
          %i(
          object_uuid
          object_title
          object_person_role
          object_description
          object_rights
          object_date
          object_keywords
          object_category
          object_resource_type
          object_value
          object_identifier
          object_related_identifier
          object_organisation_role
          object_preservation_event
          object_file
          )
        end

        public
        def call(object)
          decoders.reduce({}) {|master, decoder| master.update("::Cdm::Messaging::#{decoder.to_s.classify}".constantize.(object))}
        end
      end
    end
  end
end
