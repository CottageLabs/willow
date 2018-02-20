require 'spec_helper'

RSpec.describe ::Cdm::Json::Organisation do
  let(:values) do
    {
      jisc_id: 123,
      name: 'Some organisation',
      organisation_type: 'further_education',
      address: "1 The Street\nThe Road"
    }.to_json
  end

  subject { described_class.new(JSON.parse(values)) }

  it 'is an ::Cdm::Json::Organisation' do
    expect(subject).to be_a(::Cdm::Json::Organisation)
  end

  it 'has the correct Jisc ID' do
    expect(subject.jisc_id).to eq(123)
  end

  it 'has the correct orgainisation name' do
    expect(subject.name).to eq('Some organisation')
  end

  it 'has the correct organisation type' do
    expect(subject.organisation_type).to eq('further_education')
  end

  it 'has the correct address' do
    expect(subject.address).to eq("1 The Street\nThe Road")
  end
end
