require 'spec_helper'

RSpec.describe ::Cdm::Messaging::Enumerations::Decoder do
  describe 'decodes messaging sections' do
    let(:access_type) { 'accessType' }
    let(:decoded_class) { described_class.(access_type) }
    let(:access_type_return) { %i(open safeguarded controlled restricted closed) }

    it 'should have methods for the elements in the passed section' do
      expect(decoded_class.methods).to include(*access_type_return)
    end
  end
end