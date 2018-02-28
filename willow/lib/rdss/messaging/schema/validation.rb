module Rdss
  module Messaging
    module Schema
      class Validation
        class << self
          def call(body:, event: :create, version: :current, schema_file: ::Rdss::Messaging::Schema::SchemaFile, schema_reader: ::Rdss::Messaging::Schema::VersionedSchemaReader, schema_validator: ::Rdss::Messaging::Schema::Validator)
            new(version: version, event: event, schema_file: schema_file, schema_reader: schema_reader, schema_validator: schema_validator).call(body: body)
          end
        end

        private
        attr_reader :version, :event, :schema, :schema_reader, :schema_validator

        def initialize(event: :create, version: :current, schema_file: ::Rdss::Messaging::Schema::SchemaFile, schema_reader: ::Rdss::Messaging::Schema::VersionedSchemaReader, schema_validator: ::Rdss::Messaging::Schema::Validator)
          @version=version
          @event=event
          @schema=JSON.parse(File.read(schema_file.(version: version, event: event)))
          @schema_reader=schema_reader
          @schema_validator=schema_validator
        end

        public
        def call(body:)
          schema_validator.fully_validate(schema, body, schema_reader: schema_reader.new(version: version))
        end
      end
    end
  end
end
