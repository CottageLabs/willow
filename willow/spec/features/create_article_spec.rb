# Generated via
#  `rails generate hyrax:work Article`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create an Article', vcr: true do
  context 'a logged in user' do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    scenario do
      visit new_hyrax_article_path

      fill_in 'Title', with: 'Test Article'
      fill_in 'article_creator_nested_attributes_0_first_name', with: 'Alice'
      fill_in 'article_creator_nested_attributes_0_last_name', with: 'Bob'
      fill_in 'article_creator_nested_attributes_0_orcid', with: '0000-0000-0000-0000'
      fill_in 'article_creator_nested_attributes_0_affiliation', with: 'University of Foo'
      select('Author', from: 'article_creator_nested_attributes_0_role')
      fill_in 'Publisher', with: 'Publisher of Foo'
      fill_in 'article_date_attributes_0_date', with: '01/01/2001'
      select('Journal Article/Review', from: 'article_resource_type')
      select('Public Domain Mark 1.0', from: 'article_license_nested_attributes_0_webpage')
      choose('open')
      check('agreement')
      click_on('Files')
      attach_file('files[]', "#{fixture_path}/files/hello_world.pdf")


      # cannot save without invoking Fedora and thus a problem of unrepeatable tests results...
      # click_on('Save')
      # expect(page).to have_content 'Your files are being processed'
      # expect(page).to have_content 'Test Article'
      # expect(page).to have_content 'University of Foo'
    end
  end
end
