# Generated via
#  `rails generate curation_concerns:work Dataset`
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
      login_as user
    end

    scenario do
      visit new_curation_concerns_dataset_path
      fill_in 'Title', with: 'Test Dataset'
      click_button 'Create Dataset'
      expect(page).to have_content 'Test Dataset'
    end
  end
end
