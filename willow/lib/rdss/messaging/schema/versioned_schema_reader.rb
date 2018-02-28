#Change the incoming uri of the validation to a local path with version number to allow for schema version substitution
module Rdss
  module Messaging
    module Schema
      class VersionedSchemaReader < ::JSON::Schema::Reader
        private
        attr_reader :version

        def initialize(version: :current)
          @version=version
        end

        def uri_to_file(string)
          string.gsub('/rdss/schema/',"#{Rails.root}/config/schema/#{version}/")
        end

        public
        def read(schema_uri)
          super(::JSON::Util::URI.normalized_uri(uri_to_file(schema_uri.path)))
        end
      end
    end
  end
end

