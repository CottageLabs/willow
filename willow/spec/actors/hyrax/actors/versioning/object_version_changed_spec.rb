require 'rails_helper'

RSpec.describe ObjectVersionChanged do
  let(:ability) { ::Ability.new(depositor) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:depositor) { create(:user) }

  describe "Object version changed" do
    let(:rdss_cdm) { create(:rdss_cdm, object_version: "1" ) }
    let(:attributes) { {:object_version => "2"} }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'CurationConcernApproved returns true.' do
      expect(ObjectVersionChanged.(env)).to be true
    end
  end

  describe "Object version unchanged" do
    let(:rdss_cdm) { create(:rdss_cdm, object_version: "1" ) }
    let(:attributes) { {:object_version => "1"} }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'CurationConcernApproved returns true.' do
      expect(ObjectVersionChanged.(env)).to be false
    end
  end

end
