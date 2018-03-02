# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'
require 'vcr'

RSpec.describe Hyrax::Actors::RdssCdmActor do
  let(:ability) { ::Ability.new(depositor) }
  let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:depositor) { create(:user) }
  let(:attributes) { {:title => ["a test title"]} }
  let(:rdss_cdm) { create(:rdss_cdm) }

  subject(:middleware) do
    stack = ActionDispatch::MiddlewareStack.new.tap do |middleware|
      middleware.use described_class
    end
    stack.build(terminator)
  end 

  describe "create" do
    it 'adds an object_uuid' do 
      VCR.use_cassette('rdss_cdm_actor/create_object_uuid', :match_requests_on => [:method, :host]) do
        expect { middleware.create(env) }.to change { env.attributes[:object_uuid] }.to match(/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/)
      end
    end
  end
end
