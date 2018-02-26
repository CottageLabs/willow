require 'rails_helper'
require 'vcr'

RSpec.describe Hyrax::Actors::RdssCdmObjectVersioningActor do
  let(:ability) { ::Ability.new(depositor) }
  let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:depositor) { create(:user) }
  let(:attributes) { {:object_version => "", title => "test title"} }
  let(:rdss_cdm) { create(:rdss_cdm) }

  subject(:middleware) do
    stack = ActionDispatch::MiddlewareStack.new.tap do |middleware|
      middleware.use described_class
    end
    stack.build(terminator)
  end

  describe "create" do
    it 'set object version to 1' do
      VCR.use_cassette('rdss_cdm_object_versioning_actor/set_initial_object_version', :match_requests_on => [:method, :host]) do
        expect { middleware.create(env) }.to change { env.attributes[:object_version] }.to "1"
      end
    end
  end
end
