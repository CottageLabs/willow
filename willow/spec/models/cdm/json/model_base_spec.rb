require 'spec_helper'

RSpec.describe ::Cdm::Json::ModelBase do
  subject { described_class.new }
  let(:id) { 'eabd-1234-3241-bade' }
  let(:rdss_cdm_id) { 'rdss_cdm_id_1234' }
  let(:values) { { id: id, rdss_cdm_id: rdss_cdm_id }.to_json }

  it "is a #{described_class}" do
    expect(subject).to be_a(described_class)
  end

  it 'has a nil value for id when initialized with no parameters' do
    expect(subject.id).to be_nil
  end

  it 'has a nil value for rdss_cdm_id when initialized with no parameters' do
    expect(subject.rdss_cdm_id).to be_nil
  end

  it 'sets id when passed as a value' do
    expect(described_class.new(JSON.parse({id: id}.to_json)).id).to eq(id)
  end

  it 'sets rdss_cdm_id when passed as a value' do
    expect(described_class.new(JSON.parse({rdss_cdm_id: rdss_cdm_id}.to_json)).rdss_cdm_id).to eq(rdss_cdm_id)
  end

  it 'sets all parameters when passed as a single json hash' do
    expect(described_class.new(JSON.parse(values)).id).to eq (id)
    expect(described_class.new(JSON.parse(values)).rdss_cdm_id).to eq (rdss_cdm_id)
  end
end