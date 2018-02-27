require 'rails_helper'

RSpec.describe SignificantFieldsChanged do
  let(:ability) { ::Ability.new(depositor) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:depositor) { create(:user) }

  describe "Significant fields have changed" do
    let(:attributes) { {:title => ["A different test title"]} }
    let(:rdss_cdm) { create(:rdss_cdm, title: ["A test title"] ) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'the work title has changed' do
      expect(SignificantFieldsChanged.(env)).to be true
    end
  end

  describe "Significant fields have not changed" do
    let(:attributes) { {:title => ["A test title"]} }
    let(:rdss_cdm) { create(:rdss_cdm, title: ["A test title"] ) }
    let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
    it 'the work title has not changed' do
      expect(SignificantFieldsChanged.(env)).to be false
    end
  end

end
