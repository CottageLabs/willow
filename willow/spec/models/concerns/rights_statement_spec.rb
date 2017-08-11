require 'rails_helper'

RSpec.describe RightsStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :rights_nested, predicate: ::RDF::Vocab::DC.rights, class_name:"RightsStatement"
      accepts_nested_attributes_for :rights_nested
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a rights active triple resource with an id, label, definition and webpage' do
    @obj = ExampleWork.new
    @obj.attributes = {
      rights_nested_attributes: [
        {
          label: 'A rights label',
          definition: 'A definition of the rights',
          webpage: 'http://example.com/rights'
        }
      ]
    }
    expect(@obj.rights_nested.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.rights_nested.first.label).to eq ['A rights label']
    expect(@obj.rights_nested.first.definition).to eq ['A definition of the rights']
    expect(@obj.rights_nested.first.webpage).to eq ['http://example.com/rights']
  end

  it 'has the correct uri' do
    skip "Error initializing URI"
    @obj = ExampleWork.new
    @obj.attributes = {
      rights_nested_attributes: [
        {
          label: 'A rights label',
          definition: 'A definition of the rights',
          webpage: 'http://example.com/rights'
        }
      ]
    }
    expect(@obj.rights_nested.first.id).to include('#rights')
  end
end
