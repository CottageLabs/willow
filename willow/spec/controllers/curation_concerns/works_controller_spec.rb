# Generated via
#  `rails generate curation_concerns:work Work`
require 'rails_helper'
require 'devise'
require 'support/curation_concerns/session_helpers'

describe CurationConcerns::WorksController do

  let(:user) { create(:user) }
  let(:work) { create(:work, user: user) }
  let!(:sipity_entity) do
    create(:sipity_entity, proxy_for_global_id: work.to_global_id.to_s)
  end

  before do
    sign_in user
  end


  describe '#create' do
    let(:actor) { double(create: create_status) }
    before do
      allow(CurationConcerns::CurationConcern).to receive(:actor).and_return(actor)
    end
    let(:create_status) { true }

    context 'when create is successful' do
      #let(:work) { stub_model(Work) }
      let(:work) { instance_double(Work, :id=>'foofoo1', :title=>["new title"], :to_global_id=>'foofoo', :model_name=>Work) }

      it 'creates a work' do
        allow(controller).to receive(:curation_concern).and_return(work)
        post :create, params: { work: { title: ['a title'] } }
        raise 'test2'
        expect(response).to redirect_to main_app.curation_concerns_work_path(work)
        raise 'test3'
      end
    end

    context 'when create fails' do
      let(:create_status) { false }
      it 'draws the form again' do
        post :create, params: { generic_work: { title: ['a title'] } }
        expect(response.status).to eq 422
        expect(assigns[:form]).to be_kind_of CurationConcerns::GenericWorkForm
        expect(response).to render_template 'new'
      end
    end
  end


  describe '#show' do
    context 'my own private work' do
      let(:work) { create(:private_work, user: user) }
      it 'shows me the page' do
        get :show, params: { id: work }
        expect(response).to be_success
      end

      context "with a parent work" do
        let(:parent) { create(:work, title: ['Parent Work'], user: user, ordered_members: [work]) }
        let!(:parent_sipity_entity) do
          create(:sipity_entity, proxy_for_global_id: parent.to_global_id.to_s)
        end
        it "sets the parent presenter" do
          get :show, params: { id: work, parent_id: parent }
          expect(response).to be_success
          expect(assigns[:parent_presenter]).to be_instance_of CurationConcerns::WorkShowPresenter
        end
      end
    end

    context 'someone elses private work' do
      let(:work) { create(:private_work) }
      it 'shows unauthorized message' do
        get :show, params: { id: work }
        expect(response.code).to eq '401'
        expect(response).to render_template(:unauthorized)
      end
    end

    context 'someone elses public work' do
      let(:work) { create(:public_work) }
      context "html" do
        it 'shows me the page' do
          expect(controller). to receive(:additional_response_formats).with(ActionController::MimeResponds::Collector)
          get :show, params: { id: work }
          expect(response).to be_success
        end
      end

      context "ttl" do
        let(:presenter) { double }
        before do
          allow(controller).to receive(:presenter).and_return(presenter)
          allow(presenter).to receive(:export_as_ttl).and_return("ttl graph")
        end

        it 'renders a turtle file' do
          get :show, params: { id: '99999999', format: :ttl }
          expect(response).to be_successful
          expect(response.body).to eq "ttl graph"
          expect(response.content_type).to eq 'text/turtle'
        end
      end
    end
  end

end
