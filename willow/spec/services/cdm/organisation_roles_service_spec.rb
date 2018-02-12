require 'rails_helper'

describe Cdm::ObjectOrganisationRolesService do
  describe "#select_all_options" do
    it "returns all terms" do
      expect(described_class.select_all_options.size).to eq(10)
      expect(described_class.select_all_options).to include(["Registration agency", :registration_agency])
    end
  end
end
