require 'rails_helper'

RSpec.describe Cdm::ObjectOrganisationRolesService do
  describe '#select_all_options' do
    it 'returns all terms' do
      expected = described_class.select_all_options
      expect(expected.size).to eq(10)
      expect(expected).to include(['Registration agency', :registration_agency])
    end
  end
end
