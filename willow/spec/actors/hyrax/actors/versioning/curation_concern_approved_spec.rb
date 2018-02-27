require 'rails_helper'

RSpec.describe CurationConcernApproved do
  let(:ability) { ::Ability.new(depositor) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:depositor) { create(:user) }
  let(:attributes) {}

  let(:active_state) { Vocab::FedoraResourceStatus.active }
  let(:inactive_state) {Vocab::FedoraResourceStatus.inactive}

  describe "work is approved" do
    let(:rdss_cdm) { create(:rdss_cdm, state: :active_state ) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'CurationConcernApproved returns true.' do
      expect(CurationConcernApproved.(env)).to be true
    end
  end

  describe "work is not approved" do
    let(:rdss_cdm) { create(:rdss_cdm, state: :inactive_state ) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'CurationConcernApproved returns false.' do
      expect(CurationConcernApproved.(env)).to be false
    end
  end

end
