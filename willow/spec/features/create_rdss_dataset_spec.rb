# Generated via
#  `rails generate hyrax:work RdssDataset`
require 'rails_helper'
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.feature 'Create a RdssDataset', vcr: true, js: false do
  context 'a logged in user' do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    scenario do
      visit new_hyrax_rdss_dataset_path

      expect(page).to have_content "Add New Dataset"
    end
  end
end
