require 'rails_helper'

RSpec.describe Hyrax::Actors::RdssCdmObjectVersioningActor do
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

  describe "create" do
    let(:attributes) { {:object_version => "", :title => ["test title"]} }
    let(:rdss_cdm) { create(:rdss_cdm) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'set object version to 1' do
      expect { middleware.create(env) }.to change { env.attributes[:object_version] }.to "1"
    end
  end

  describe "minor update" do
    let(:attributes) { {:object_version => "1", :title => ["test title"]} }
    let(:rdss_cdm) { create(:rdss_cdm, title: ["test title"], object_version: "1", state: active_state) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'object version remains 1' do
      expect { middleware.update(env) }.not_to change { env.attributes[:object_version] }
    end
  end

  describe "major update to title" do
    let(:attributes) { {:object_version => "1", :title => ["another test title"]} }
    let(:rdss_cdm) { create(:rdss_cdm, title: ["test title"], object_version: "1", state: active_state) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'object version increments to 2' do
      expect { middleware.update(env) }.to change { env.attributes[:object_version] }.to "2"
    end
  end

  describe "major update to uploaded files" do
    let(:attributes) { {:object_version => "1", :title => ["test title"], :uploaded_files => [1,2]} }
    let(:rdss_cdm) { create(:rdss_cdm, title: ["test title"], object_version: "1", state: active_state) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'object version increments to 2' do
      expect { middleware.update(env) }.to change { env.attributes[:object_version] }.to "2"
    end
  end

  describe "major unpublished update" do
    let(:attributes) { {:object_version => "1", :title => ["another test title"]} }
    let(:rdss_cdm) { create(:rdss_cdm, title: ["test title"], object_version: "1", state: inactive_state) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'object version increments to 2' do
      expect { middleware.update(env) }.not_to change { env.attributes[:object_version] }
    end
  end



end
