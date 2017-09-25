require 'rails_helper'

RSpec.describe Organisation do
  it "should have many persons" do
    t = Organisation.reflect_on_association(:persons)
    expect(t.macro).to eq(:has_many)
  end
end

RSpec.describe Person do
  it "should belong to organisation" do
    t = Person.reflect_on_association(:organisation)
    expect(t.macro).to eq(:has_and_belongs_to_many)
  end

  it "should index the organisation" do
    skip "need to create vcr for association"
    @org1 = build(:organisation, org_name: ['Paddington and Company'])
    @org2 = build(:organisation, org_name: ['Baloo and Company'])
    @person = build(:person, first_name: ['Paddington'], last_name: ['Brown'],
      organisations: [@org1, @org2])
    @doc = @person.to_solr
    expect(@doc['organisation_tesim']).to eq(['Paddington and Company', 'Baloo and Company'])
    expect(@doc).to include('organisation_ssm')
  end
end
