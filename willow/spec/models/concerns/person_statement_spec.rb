require 'rails_helper'

describe PersonStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :creator, predicate: ::RDF::Vocab::DC.creator, class_name:"PersonStatement"
      accepts_nested_attributes_for :creator
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a person active triple resource with an id, first name, last name, orcid and role' do
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_attributes: [
        {
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000',
          affiliation: 'author affiliation',
          role: 'Author'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.creator.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.creator.first.id).to include('#person')
    expect(@obj.creator.first.first_name).to eq ['Foo']
    expect(@obj.creator.first.last_name).to eq ['Bar']
    expect(@obj.creator.first.orcid).to eq ['0000-0000-0000-0000']
    expect(@obj.creator.first.affiliation).to eq ['author affiliation'bg]
    expect(@obj.creator.first.role).to eq ['Author']
  end

  it 'defines role qualifiers' do
    expect(PersonStatement.role_qualifiers).to be_kind_of Array
    expect(PersonStatement.role_qualifiers).not_to be_empty
  end

  it 'defines identifier qualifiers' do
    expect(PersonStatement.id_qualifiers).to be_kind_of Hash
    expect(PersonStatement.id_qualifiers).not_to be_empty
  end
end
