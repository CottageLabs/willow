require 'rails_helper'
require 'vcr'
#
# VCR.configure do |c|
#   c.allow_http_connections_when_no_cassette = true
# end

RSpec.describe ::Cdm::Messaging::MessageBody do
  describe 'generates a message body with a passed CDM object' do
    VCR.use_cassette('rdss_cdm')
    let(:cdm_object) { ::RdssCdm.new({id: 'test'}) }

    it 'should generate a message body hash' do
      expect(described_class.(cdm_object)).to be { {"objectUuid":'test'} }
    end
  end
end