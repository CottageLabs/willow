# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.feature 'Create a RdssCdm', vcr: true, js: false do
  context 'a logged in user' do
    xit %q(temporarily disables the VCR running tests because they aren't being regenerated and give false positive results working) do
      let(:user) { create(:user) }

      before do
        login_as user
      end

      scenario do
        if(RdssCdm.content_type_enabled?)
          visit new_hyrax_rdss_cdm_path

          expect(page).to have_content "Add New RDSS CDM"
          fill_in 'Title', with: 'Test RdssCDM'
          click_on('Additional fields')
          fill_in 'Description', with: 'description'
          fill_in 'Keywords', with: 'keywords'
          fill_in 'Category', with: 'category'
          fill_in 'Version', with: 'version'
          select 'Article', from: 'Resource type'
          select 'Normal', from: 'Object value'
          choose('open')
          check('agreement')
          click_on('Files')
          attach_file('files[]', "#{fixture_path}/files/hello_world.pdf")

          # cannot save without invoking Fedora and thus a problem of unrepeatable tests results...
        end
      end
    end
  end
end
