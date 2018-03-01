#Generate the file name of the Schema file to be used with versioning and the CRUD event type
module Rdss
  module Messaging
    module Schema
      class SchemaFile
        class << self
          def call(event: 'create', version: 'current')
            new.call(event: event, version: version)
          end
        end

        private
        def initialize(schema_root: 'config/schema', schema_path: 'messages/body/metadata', schema_file: 'request_schema.json')
          @schema_root=schema_root
          @schema_path=schema_path
          @schema_file=schema_file
        end

        def fully_qualified_filename(event:, version:)
          File.join(Rails.root, @schema_root, version.to_s, @schema_path, event.to_s, @schema_file)
        end

        public
        def call(event: 'create', version: 'current')
          fully_qualified_filename(event: event, version: version)
        end
      end
    end
  end
end