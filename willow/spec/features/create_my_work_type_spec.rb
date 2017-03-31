# Generated via
#  `rails generate curation_concerns:work MyWorkType`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a MyWorkType' do
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
      visit new_curation_concerns_my_work_type_path
      fill_in 'Title', with: 'Test MyWorkType'
      click_button 'Create MyWorkType'
      expect(page).to have_content 'Test MyWorkType'
    end
  end
end
