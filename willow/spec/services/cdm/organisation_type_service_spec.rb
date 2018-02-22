require 'rails_helper'

RSpec.describe Cdm::ObjectOrganisationTypesService do
  describe '#select_all_options' do
    it 'returns all items' do
      expected = described_class.select_all_options
      expect(expected).to be_a(Array)
      expect(expected).to include(['Charity', :charity])
    end
  end
end
