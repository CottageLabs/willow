# Generated via
#  `rails generate hyrax:work Dataset`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a Dataset' do
  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      # AdminSet.find_or_create_default_admin_set_id
      login_as user
    end

    scenario do
      visit '/dashboard'
      click_link "Works"
      click_link "Add new work"

      choose "payload_concern", option: "Dataset"
      click_button "Create work"

      expect(page).to have_content "Add New Dataset"

      fill_in 'Title', with: 'Test Dataset'
      click_button 'Create Dataset'
      expect(page).to have_content 'Test Dataset'
    end
  end
end
