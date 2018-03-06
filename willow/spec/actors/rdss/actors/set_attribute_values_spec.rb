require 'spec_helper'
class Dummy
  attr_reader :attributes

  def initialize(attr={})
    @attributes=attr
  end
end

describe ::Rdss::Actors::SetAttributeValues do
  let(:env) { Dummy.new }
  let(:empty_env) { Dummy.new({ first: '', second: nil })}
  let(:populated_env) { Dummy.new({first: 'populated', third: 'also populated', forth: nil, fifth: ''})}
  let(:default_values) { {first: 'one', second: 'two'} }

  it 'sets values if missing' do
    described_class.(env, default_values)
    expect(env.attributes).to eq(default_values)
  end

  it 'sets values if empty or nil' do
    described_class.(empty_env, default_values)
    expect(empty_env.attributes).to eq(default_values)
  end

  it 'overrides values if already set and does not touch the other values' do
    described_class.(populated_env, default_values)
    expect(populated_env.attributes).to eq({ first: 'one', second: 'two', third: 'also populated', forth: nil, fifth: ''})
  end
end