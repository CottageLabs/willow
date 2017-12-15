# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.feature 'Create a RdssCdm', vcr: true, js: false do
  context 'a logged in user' do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    scenario do
      visit new_hyrax_rdss_cdm_path

      expect(page).to have_content "Add New RDSS CDM"
    end
  end
end