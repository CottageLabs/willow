# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a Image', vcr: true do
  context 'a logged in user' do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    scenario do
      if(Image.content_type_enabled?)
        visit new_hyrax_image_path

        fill_in 'Title', with: 'Test Image'
        fill_in 'Creator', with: 'Alice Bob'
        fill_in 'Keyword', with: 'Foo'
        select('In Copyright', from: 'Rights statement')
        choose('open')
        check('agreement')
        click_on('Files')
        attach_file('files[]', "#{fixture_path}/files/hello_world.pdf")

        # cannot save without invoking Fedora and thus a problem of unrepeatable tests results...
      end
    end
  end
end
