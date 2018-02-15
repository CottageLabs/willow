require 'rails_helper'

RSpec.describe ::Cdm::Messaging::Enumerations::Decoders::File do
  describe 'caches messaging file sections' do
    let(:access_type) { 'accessType' }
    let(:built_section) { described_class.call(access_type)}
    let(:access_type_return) { %w(open safeguarded controlled restricted closed) }

    it 'should raise an error if #new is called' do
      expect { described_class.new }.to raise_error NoMethodError
    end

    it 'should return a json extract if called with a section' do
      expect(built_section).to eq access_type_return
    end

    it 'should return a list of the file sections' do
      expect(described_class.sections).to include(access_type)
    end
  end
end