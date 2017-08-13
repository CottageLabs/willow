# Generated via
#  `rails generate hyrax:work Dataset`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a Dataset', vcr: true do
  context 'a logged in user' do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    scenario do
      visit new_hyrax_dataset_path

      fill_in 'Title', with: 'Test Dataset'
      fill_in 'dataset_creator_nested_attributes_0_first_name', with: 'Alice'
      fill_in 'dataset_creator_nested_attributes_0_last_name', with: 'Bob'
      fill_in 'dataset_creator_nested_attributes_0_orcid', with: '0000-0000-0000-0000'
      fill_in 'dataset_creator_nested_attributes_0_affiliation', with: 'University of Foo'
      select('Data collector', from: 'dataset_creator_nested_attributes_0_role')
      fill_in 'Publisher', with: 'Publisher of Foo'
      fill_in 'dataset_date_attributes_0_date', with: '01/01/2001'
      select('Dataset', from: 'Resource type')
      select('Public Domain Mark 1.0', from: 'dataset_rights_nested_attributes_0_webpage')
      choose('open')
      check('agreement')
      click_on('Files')
      attach_file('files[]', "#{fixture_path}/files/hello_world.pdf")

      # cannot save without invoking Fedora and thus a problem of unrepeatable tests results...
    end
  end
end
