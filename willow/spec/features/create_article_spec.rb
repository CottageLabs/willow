# Generated via
#  `rails generate hyrax:work Article`
require 'rails_helper'
require 'support/hyrax/workflow_helpers'
include Warden::Test::Helpers

RSpec.feature 'Create an Article', vcr: true, js: false do
  context 'a logged in user' do

    let(:create_status) { true }
    let(:actor) { double(create: create_status) }
    let(:user) { create(:user) }

    let(:article) { create(:article,
                           id: 'A-0000000',
                           depositor: user.email,
                           title: ['Do Mug Fairies Exist? An experiment in self-cleaning crockery'],
                           resource_type: ["Article"],
                           creator_nested_attributes: [{
                                                           first_name: 'Ed',
                                                           last_name: 'Pentz',
                                                           orcid: '0000-0000-0000-0000',
                                                           affiliation: 'Author affiliation',
                                                           role: 'Author'
                                                       },
                                                       {
                                                           first_name: 'Hello',
                                                           last_name: 'World',
                                                           orcid: '0001-0001-0001-0001',
                                                           role: 'Author'
                                                       }],
                           description: ['The author set out to prove that if coffee or tea mugs are left in an office for ' +
                                             'long enough they will clean themselves. Previous research in this area suggest ' +
                                             'that this hypothesis is true, as the author has very infrequently had to resort ' +
                                             'to cleaning the mugs himself.'],
                           keyword: ["mug", "fairies", "psychoceramics"],
                           rights_nested_attributes: [{
                                                          label: 'A rights label',
                                                          definition: 'A definition of the rights',
                                                          webpage: 'http://creativecommons.org/publicdomain/zero/1.0/'
                                                      }],
                           publisher: ["Society of Psychoceramics"],
                           date_attributes: [{
                                                 date: '2017-01-01',
                                                 description: 'http://purl.org/dc/terms/dateAccepted',
                                             }],
                           doi: "http://dx.doi.org/10.5555/2014-04-01",
                           subject_nested_attributes: [{
                                                           label: 'Psychoceramics',
                                                           definition: 'The study of cracked pots',
                                                           classification: 'PSC',
                                                           homepage: 'http://example.com/homepage'
                                                       }],
                           language: ["English"]
    ) }

    before do
      #allow(Hyrax::CurationConcern).to receive(:actor).and_return(actor)
      #allow(controller).to receive(:hyrax).and_return(article)

      #load_default_workflow
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
      select('Public Domain Mark 1.0', from: 'article_rights_nested_attributes_0_webpage')
      choose('open')
      check('agreement')
      click_on('Files')
      attach_file('files[]', "#{fixture_path}/files/hello_world.pdf")


      # cannot save without invoking Fedora and then a problem of unrepeatable tests results...

      # click_on('Save')
      #
      # expect(page).to have_content 'Your files are being processed'
      # expect(page).to have_content 'Test Article'
      # expect(page).to have_content 'University of Foo'
    end
  end
end
