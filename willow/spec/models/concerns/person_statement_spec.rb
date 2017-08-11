require 'rails_helper'

RSpec.describe PersonStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :creator_nested, predicate: ::RDF::Vocab::DC.creator, class_name:"PersonStatement"
      accepts_nested_attributes_for :creator_nested
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a person active triple resource with an id, first name, last name, orcid and role' do
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_nested_attributes: [
        {
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000',
          affiliation: 'author affiliation',
          role: 'Author'
        }
      ]
    }
    expect(@obj.creator_nested.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.creator_nested.first.first_name).to eq ['Foo']
    expect(@obj.creator_nested.first.last_name).to eq ['Bar']
    expect(@obj.creator_nested.first.orcid).to eq ['0000-0000-0000-0000']
    expect(@obj.creator_nested.first.affiliation).to eq ['author affiliation']
    expect(@obj.creator_nested.first.role).to eq ['Author']
  end

  it 'has the correct uri' do
    skip "Error initializing URI"
    @obj = ExampleWork.new
    @obj.attributes = {
      creator_nested_attributes: [
        {
          first_name: 'Foo',
          last_name: 'Bar',
          orcid: '0000-0000-0000-0000',
          affiliation: 'author affiliation',
          role: 'Author'
        }
      ]
    }
    expect(@obj.creator_nested.first.id).to include('#person')
  end
end
