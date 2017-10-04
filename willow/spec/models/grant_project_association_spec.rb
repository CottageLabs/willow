require 'rails_helper'

RSpec.describe Grant do
  it "should have many projects" do
    t = Grant.reflect_on_association(:projects)
    expect(t.macro).to eq(:has_many)
  end
end

RSpec.describe Project do
  it "should belong to many grants" do
    t = Project.reflect_on_association(:grant)
    expect(t.macro).to eq(:has_and_belongs_to_many)
  end

  it "should index the grant" do
    skip "need to create vcr for association"
    @grant1 = build(:grant, title: ['Grant 1'], value: ['£10,000.00'])
    @grant2 = build(:grant, title: ['Grant 2'], value: ['£20,000.00'])
    @project = build(:project, title: ['Projectwith funding'], grants: [@grant1, @grant2])
    @doc = @project.to_solr
    expect(@doc['grant_tesim']).to eq(['Grant 1', 'Grant 2'])
    expect(@doc).to include('grant_ssm')
  end
end
