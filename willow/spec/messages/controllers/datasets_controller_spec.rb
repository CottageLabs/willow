require 'rails_helper'
require 'support/hyrax/session_helpers'
require 'support/notifications'
require 'support/jisc_rdss_schemas'

# NB: these tests require some files which cannot be committed to git (yet)
# In order to successfully run them, ensure the path "/willow/spec/fixtures/files/schemas/jisc_rdss/*" is in your
# .gitignore file.
#
# Then, copy the following files and folders to the given locations:
# *  https://github.com/JiscRDSS/rdss-message-api-docs/tree/master/messages  => willow/willow/spec/fixtures/files/schemas/jisc_rdss/messages
# *  https://github.com/JiscRDSS/rdss-message-api-docs/tree/master/schemas   => willow/willow/spec/fixtures/files/schemas/jisc_rdss/schemas
#
# Be sure that the files above are not committed to git!


describe Hyrax::DatasetsController, :type => :controller do
  let(:depositor_user) { create(:user, email: 'josiah@example.com', title: 'Professor of Psychoceramics',
                                display_name: 'Josiah Carberry', orcid: '0000-0002-1825-0097' ) }
  let(:dataset) { create(:dataset,
                         id: 'A-0000000',
                         depositor: depositor_user.email,
                         title: ['Do Mug Fairies Exist? An experiment in self-cleaning crockery'],
                         resource_type: ["Dataset"],
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
                         license_nested_attributes: [{
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
                         language: ["English"],
                         import_url: 'true'
  ) }


  before :all do
    @validator = load_validator_with_jisc_rdss_schemas()
  end

  before :each do
    sign_in depositor_user
  end

  describe '#create' do
    let(:create_status) { true }
    let(:actor) { double(create: create_status) }

    before :each do
      allow(Hyrax::CurationConcern).to receive(:actor).and_return(actor)
      allow(controller).to receive(:curation_concern).and_return(dataset)
      post :create, params: { dataset: { title: [''] } }
      @message = notification_message_for(Hyrax::Notifications::Events::METADATA_UPDATE) do
        # trigger the approve workflow message
        Hyrax::Notifications::Senders::Approve.call(target: dataset)
      end
      @messageHeader=@message[:messageHeader]
      @messageBody=@message[:messageBody]
      @messageBodyPayload=@messageBody[:payload]
      @jsonPayload=JSON.pretty_generate(@messageBodyPayload)
    end

    it 'schema validated payload' do
      expect(@jsonPayload).to_not be_nil

      expect(@validator.fully_validate(
          file_fixture("schemas/jisc_rdss/messages/metadata/create/request_schema.json").read,
          @jsonPayload)).to be_empty
    end

    it 'messageType is create' do
      expect(@messageHeader[:messageType]).to eql('MetadataUpdate')
    end

    it 'payload contains objectTitle' do
      expect(@messageBodyPayload[:objectTitle]).to eql('Do Mug Fairies Exist? An experiment in self-cleaning crockery')
    end
  end
end
