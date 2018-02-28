#Override the fully_validate to use a schema reader with versioning for https uri to file uri substitution
module Rdss
  module Messaging
    module Schema
      class Validator < ::JSON::Validator
        class << self
          def fully_validate(schema, body, schema_reader: VersionedSchemaReader.new)
            super(schema, body, schema_reader: schema_reader)
          end
        end
      end
    end
  end
end
