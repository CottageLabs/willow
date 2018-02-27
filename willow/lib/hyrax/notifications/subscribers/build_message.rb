require 'securerandom'

module Hyrax
  module Notifications
    module Subscribers
      class MappedFileReader < ::JSON::Schema::Reader
        def uri_to_file(string)
          string.gsub('/rdss/',"#{Rails.root}/config/")
        end

        def read(schema_uri)
          super(::JSON::Util::URI.normalized_uri(uri_to_file(schema_uri.path)))
        end
      end

      class BuildMessage
        include Hyrax::Engine.routes.url_helpers
        attr_reader :body

        private
        def initialize(event, payload)
          @event = event
          @object = payload[:object]
          @body=::Cdm::Messaging::RdssCdm.(@object, event_shortname)
        end

        def schema_file
          "#{Rails.root}/config/schema/messages/body/metadata/#{event_shortname}/request_schema.json"
          # "https://github.com/JiscRDSS/rdss-message-api-specification/tree/2.0.0/messages/body/metadata/#{event_shortname}/request_schema.json"
        end

        def event_shortname
          @event=~/Metadata(.*)/
          $1.underscore.downcase.intern
        end

        def header()
          validation=JSON::Validator.fully_validate(JSON.parse(File.read(schema_file)), body, schema_reader: MappedFileReader.new)
          ::Rdss::Messaging::Header.(validation)
        end

        public
        def to_message
          {
            messageHeader: header,
            messageBody: body
          }
        end
      end
    end
  end
end
