# Generated via
#  `rails generate hyrax:work RdssDataset`
require 'rails_helper'
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.feature 'Create a RdssDataset', vcr: true, js: false do
  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      AdminSet.find_or_create_default_admin_set_id
      login_as user
    end

    scenario do
      visit new_hyrax_rdss_dataset_path

      expect(page).to have_content "Add New RDSS Dataset"
    end
  end
end
