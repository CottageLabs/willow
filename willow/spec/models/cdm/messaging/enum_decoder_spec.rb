require 'rails_helper'

RSpec.describe ::Cdm::Messaging::EnumDecoder do
  describe 'caches messaging file sections' do
    let(:access_type) { 'accessType' }
    let(:built_section) { described_class.call(access_type)}
    let(:access_type_return) { %w(open safeguarded controlled restricted closed) }

    it 'should return a json extract if called with a section' do
      expect(built_section).to eq access_type_return
    end
  end
end