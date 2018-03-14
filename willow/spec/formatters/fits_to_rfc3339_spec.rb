require 'spec_helper'

describe FitsToRfc3339 do
  let(:short_date) { "18:03:14" }
  let(:formats) { "%y:%m" }
  let(:long_date) { "2018:03:14 08:54:00Z" }
  let(:range_date) {"2018:03:14 08:54-16:00"}
  let(:epoch) { Time.at(0).rfc3339 }

  it 'returns epoch for nil date values' do
    expect(described_class.(nil)).to eq(epoch)
  end

  it 'returns epoch for empty date values' do
    expect(described_class.('')).to eq(epoch)
  end

  it 'returns long date for full fits date format' do
    expect(described_class.(long_date)).to eq("2018-03-14T08:54:00+00:00")
  end

  it 'returns date for short date format if overridden with a valid format' do
    expect(described_class.new(short_date).(formats)).to eq("2018-03-01T00:00:00+00:00")
  end

  it 'returns short dates when presented with fits date range values' do
    expect(described_class.(range_date)).to eq("2018-03-14T00:00:00+00:00")
  end
end