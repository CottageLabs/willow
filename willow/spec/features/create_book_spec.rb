# Generated via
#  `rails generate hyrax:work Book`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a Book' do
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
      visit '/dashboard'
      click_link "Works"
      click_link "Add new work"

      choose "payload_concern", option: "Book"
      click_button "Create work"

      expect(page).to have_content "Add New Book"
    end
  end
end
