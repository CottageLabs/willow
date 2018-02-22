require 'spec_helper'

RSpec.describe ::Cdm::Json::ObjectOrganisationRole do
  let(:values) do
    {
      role: 'SomeRole',
      organisation: {
        jisc_id: 123
      }
    }.to_json
  end

  subject { described_class.new(JSON.parse(values)) }

  it 'has the correct role as symbol' do
    expect(subject.role).to eq(:some_role)
  end

  describe 'organisation' do
    it 'is an instance of ObjectOrganisation' do
      expect(subject.organisation).to be_a(::Cdm::Json::Organisation)
    end
  end
end
