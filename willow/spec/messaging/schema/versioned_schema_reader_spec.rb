require 'rails_helper'

RSpec.describe Rdss::Messaging::Schema::VersionedSchemaReader do
  let(:original_schema_file) { "https://www.jisc.ac.uk/rdss/schema/messages/body/metadata/create/request_schema.json" }
  let(:parsed_schema_file) { ::JSON::Util::URI.normalized_uri(original_schema_file) }
  let(:current_schema_file) { "#{Rails.root}/config/schema/current/messages/body/metadata/create/request_schema.json" }
  let(:version2_schema_file) { "#{Rails.root}/config/schema/2.0.0/messages/body/metadata/create/request_schema.json" }

  describe 'reader should map https path to local file' do
    it "maps uri to default path" do
      mapper=described_class.new
      expect(mapper.send(:uri_to_file, parsed_schema_file.path)).to eq(current_schema_file)
    end

    it "maps uri to version path" do
      mapper=described_class.new(version: '2.0.0')
      expect(mapper.send(:uri_to_file, parsed_schema_file.path)).to eq(version2_schema_file)
    end
  end
end

