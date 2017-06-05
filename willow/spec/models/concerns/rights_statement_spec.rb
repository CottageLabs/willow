require 'rails_helper'

describe RightsStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :rights, predicate: ::RDF::Vocab::DC.rights, class_name:"RightsStatement"
      accepts_nested_attributes_for :rights
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a rights active triple resource with an id, label, definition and webpage' do
    @obj = ExampleWork.new
    @obj.attributes = {
      rights_attributes: [
        {
          label: 'A rights label',
          definition: 'A definition of the rights',
          webpage: 'http://example.com/rights'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.rights.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.rights.first.id).to include('#rights')
    expect(@obj.rights.first.label).to eq ['A rights label']
    expect(@obj.rights.first.definition).to eq ['A definition of the rights']
    expect(@obj.rights.first.webpage).to eq ['http://example.com/rights']
  end

  it 'defines qualifiers' do
    expect(RightsStatement.qualifiers).to be_kind_of Array
    expect(RightsStatement.qualifiers).not_to be_empty
  end
end
