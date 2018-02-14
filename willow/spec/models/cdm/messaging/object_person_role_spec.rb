require 'rails_helper'

RSpec.describe ::Cdm::Messaging::ObjectPersonRole do
  describe 'does stuff' do
    it 'should return 1 for #administrator' do
      expect(described_class.administrator).to eq '1'
    end
  end
end