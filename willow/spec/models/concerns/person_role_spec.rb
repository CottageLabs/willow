require 'rails_helper'

RSpec.describe PersonRole do
  it 'has a role' do
    @obj = build(:person_role, role: 'Creator')
    expect(@obj.role).to be_kind_of String
    expect(@obj.role).to eq 'Creator'
  end

  it "should belong to person" do
    t = PersonRole.reflect_on_association(:person)
    expect(t.macro).to eq(:belongs_to)
  end

  it "should belong to and have many rdss datasets" do
    t = PersonRole.reflect_on_association(:rdss_datasets)
    expect(t.macro).to eq(:has_and_belongs_to_many)
  end

end
