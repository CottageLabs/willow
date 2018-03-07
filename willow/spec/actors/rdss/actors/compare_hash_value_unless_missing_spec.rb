require 'spec_helper'

describe ::Rdss::Actors::CompareHashValueUnlessMissing do
  let(:blank_hash_value) { nil }
  let(:empty_hash_value) { '' }
  let(:present_hash_value) { 'populated' }

  it 'returns true if attribute not set' do
    expect(described_class.(blank_hash_value, present_hash_value)).to be_truthy
  end

  it 'returns false if attribute set but different' do
    expect(described_class.(empty_hash_value, present_hash_value)).to be_falsey
  end

  it 'returns true if values are the same' do
    expect(described_class.(present_hash_value, 'populated')).to be_truthy
  end
end