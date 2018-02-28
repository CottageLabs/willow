require 'rails_helper'

RSpec.describe Rdss::Messaging::Actors::MessagePublisherActor do
  let(:ability) { ::Ability.new(depositor) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:depositor) { create(:user) }

  let(:active_state) {Vocab::FedoraResourceStatus.active}
  let(:inactive_state) {Vocab::FedoraResourceStatus.inactive}

  subject(:middleware) do
    stack = ActionDispatch::MiddlewareStack.new.tap do |middleware|
      middleware.use described_class
    end
    stack.build(terminator)
  end

  describe "Approved update with minor changes" do
    let(:attributes) { {:object_version => "1"} }
    let(:rdss_cdm) { create(:rdss_cdm, state: active_state, object_version: "1") }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'broadcasts a minor update' do
      VCR.use_cassette('kinesis/update', :match_requests_on => [:method, :host]) do
        expect { middleware.update(env) }.to broadcast(:work_update_minor)
      end
    end
  end

  describe "Approved update with major changes" do
    let(:attributes) { {:object_version => "1"} }
    let(:rdss_cdm) { create(:rdss_cdm, state: active_state, object_version: "2") }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'broadcasts a major update' do
      VCR.use_cassette('kinesis/create', :match_requests_on => [:method, :host]) do
        expect { middleware.update(env) }.to broadcast(:work_update_major)
      end
    end
  end

  describe "Unapproved update with minor changes" do
    let(:attributes) { {:object_version => "1"} }
    let(:rdss_cdm) { create(:rdss_cdm, state: inactive_state, object_version: "1") }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'does not broadcast a minor update' do
      expect { middleware.update(env) }.not_to broadcast(:work_update_minor)
    end
  end

  describe "Unapproved update with major changes" do
    let(:attributes) { {:object_version => "1"} }
    let(:rdss_cdm) { create(:rdss_cdm, state: inactive_state, object_version: "2") }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'does not broadcast a major update' do
      expect { middleware.update(env) }.not_to broadcast(:work_update_major)
    end
  end

  describe "A destroy" do
    let(:attributes) {}
    let(:rdss_cdm) { create(:rdss_cdm) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'broadcasts a destroy event' do
      expect { middleware.update(env) }.not_to broadcast(:work_destroy)
    end
  end
end
