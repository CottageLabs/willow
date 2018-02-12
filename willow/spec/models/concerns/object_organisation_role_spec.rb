require 'rails_helper'

RSpec.describe OrganisationRole do
  it 'has a role' do
    @obj = build(:organisation_role, role: 'Publisher')
    expect(@obj.role).to be_kind_of String
    expect(@obj.role).to eq 'Publisher'
  end

  it "should belong to organisation" do
    t = OrganisationRole.reflect_on_association(:organisation)
    expect(t.macro).to eq(:belongs_to)
  end

  it "should belong to and have many rdss datasets" do
    t = OrganisationRole.reflect_on_association(:rdss_datasets)
    expect(t.macro).to eq(:has_and_belongs_to_many)
  end

end
