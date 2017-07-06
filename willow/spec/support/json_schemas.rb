require 'json'
require 'json-schema'

def load_validator_with_schemas(schema_path)
  validator = JSON::Validator
  if Dir.exist?(schema_path)
    Dir.glob(File.join(schema_path, "*.json")).each do |file|
      schema = JSON.parse(File.read(file))
      puts "Loading schema #{File.basename(file)} => #{schema["id"]}"
      validator.add_schema(JSON::Schema.new(schema, Addressable::URI.parse(schema["id"])))
    end
  else
    # If the schemas folder is missing, we can't run the tests, so skip them for the present
    # Consider failing them in future once the schemas can be guaranteed (which they can't be at the moment)
    skip("WARNING: Schema path does not exist: #{schema_path}. See willow/spec/fixtures/files/schemas/README.txt for more information.")
  end
  return validator
end
