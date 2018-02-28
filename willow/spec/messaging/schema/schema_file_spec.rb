require 'rails_helper'

RSpec.describe Rdss::Messaging::Schema::SchemaFile do
  let(:default_root) { "#{Rails.root}/config/schema" }
  let(:default_version) { "current" }
  let(:default_path) { 'messages/body/metadata' }
  let(:default_event) { :create }
  let(:default_file) { 'request_schema.json' }

  describe 'empty parameter block' do
    it "Class called with no parameters to return current create path" do
      expect(described_class.()).to eq("#{default_root}/#{default_version}/#{default_path}/#{default_event}/#{default_file}")
    end

    it "Instantiated and called with no parameters to return current create path" do
      expect(described_class.new.()).to eq("#{default_root}/#{default_version}/#{default_path}/#{default_event}/#{default_file}")
    end
  end

  describe 'named parameter block' do
    let(:event) { :update }
    let(:version) { '2.0.0' }
    let(:override_file) { 'response.json' }

    it 'called with an event override to return event path' do
      expect(described_class.(event: event)).to eq("#{default_root}/#{default_version}/#{default_path}/#{event}/#{default_file}")
    end

    it 'called with a version override to return version path' do
      expect(described_class.(version: version)).to eq("#{default_root}/#{version}/#{default_path}/#{default_event}/#{default_file}")
    end

    it 'instantiated and called with event will return event path' do
      expect(described_class.new.(event: event)).to eq("#{default_root}/#{default_version}/#{default_path}/#{event}/#{default_file}")
    end

    it 'created with a different file and called with a version will return new file and version' do
      expect(described_class.new(schema_file: override_file).call(event: event)).to eq("#{default_root}/#{default_version}/#{default_path}/#{event}/#{override_file}")
    end
  end
end

