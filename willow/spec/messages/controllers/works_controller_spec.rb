require 'rails_helper'
require 'support/curation_concerns/session_helpers'
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


describe CurationConcerns::WorksController, :type => :controller do
  let(:depositor_user) { create(:user, email: 'josiah@example.com', title: 'Professor of Psychoceramics',
                                display_name: 'Josiah Carberry', orcid: '0000-0002-1825-0097' ) }
  let(:work) { create(:work_with_one_file,
                      user: depositor_user,
                      title: ['Do Mug Fairies Exist? An experiment in self-cleaning crockery'],
                      resource_type: ["Article"],
                      creator: ["Ed Pentz"],
                      description: ['The author set out to prove that if coffee or tea mugs are left in an office for ' +
                                        'long enough they will clean themselves. Previous research in this area suggest ' +
                                        'that this hypothesis is true, as the author has very infrequently had to resort ' +
                                        'to cleaning the mugs himself.'],
                      keyword: ["mug", "fairies", "psychoceramics"],
                      rights: ["http://creativecommons.org/publicdomain/zero/1.0/"],
                      publisher: ["Society of Psychoceramics"],
                      date_created: ['2014-04-01'],
                      subject: ["Psychoceramics"],
                      language: ["English"]
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
      allow(CurationConcerns::CurationConcern).to receive(:actor).and_return(actor)
      allow(controller).to receive(:curation_concern).and_return(work)

      @message = notification_message_for('create_work.sufia') do
        post :create, params: { work: { title: [''] } }
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
      expect(@messageHeader[:messageType]).to eql('CREATE')
    end

    it 'payload contains objectTitle' do
      expect(@messageBodyPayload[:objectTitle]).to eql(work.title.first)
    end
  end
  #
  # describe '#update' do
  #   let(:visibility_changed) { false }
  #   let(:actor) { double(update: true) }
  #
  #   #let(:update_status) { true }
  #   #let(:actor) { double(update: update_status) }
  #
  #   before :each do
  #     # allow(CurationConcerns::CurationConcern).to receive(:actor).and_return(actor)
  #     # allow_any_instance_of(Work).to receive(:visibility_changed?).and_return(visibility_changed)
  #     # allow(controller).to receive(:curation_concern).and_return(work)
  #     # allow(controller).to receive(:update).and_return(visibility_changed)
  #     # allow(controller).to receive(:foo).and_return(visibility_changed)
  #
  #     @message = notification_message_for('update_work.sufia') do
  #       #patch :update, params: { work: { title: [''] } }
  #       patch :update, params: { id: 1, work: {} }
  #     end
  #     @messageHeader=@message[:messageHeader]
  #     @messageBody=@message[:messageBody]
  #     @messageBodyPayload=@messageBody[:payload]
  #     @jsonPayload=JSON.pretty_generate(@messageBodyPayload)
  #   end
  #
  #   # it 'schema validated payload' do
  #   #   expect(@jsonPayload).to_not be_nil
  #   #   expect(@validator.fully_validate(
  #   #       file_fixture("schemas/jisc_rdss/messages/metadata/create/request_schema.json").read,
  #   #       @jsonPayload)).to be_empty
  #   # end
  #   #
  #   # it 'messageType is update' do
  #   #   expect(@messageHeader[:messageType]).to eql('UPDATE')
  #   # end
  #
  #   it 'payload contains objectTitle' do
  #     expect(@messageBodyPayload[:objectTitle]).to eql(work.title.first)
  #   end
  # end
end
