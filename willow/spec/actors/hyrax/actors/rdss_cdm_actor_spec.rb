# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'
require 'vcr'

RSpec.describe Hyrax::Actors::RdssCdmActor do
  let(:ability) { ::Ability.new(depositor) }
  let(:env) { Hyrax::Actors::Environment.new(rdss_cdm, ability, attributes) }
  let(:terminator) { Hyrax::Actors::Terminator.new }
  let(:depositor) { create(:user) }
  let(:attributes) { {:title => ["a test title"], object_value: nil} }
  let(:rdss_cdm) { create(:rdss_cdm) }

  subject(:middleware) do
    stack = ActionDispatch::MiddlewareStack.new.tap do |middleware|
      middleware.use described_class
    end
    stack.build(terminator)
  end 

  describe "create" do
    it 'set object_value to :normal' do 
      expect { middleware.create(env) }.to change { env.attributes[:object_value] }.to :normal
    end
  end
end
