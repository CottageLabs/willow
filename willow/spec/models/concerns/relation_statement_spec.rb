require 'rails_helper'

describe RelationStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
      accepts_nested_attributes_for :relation
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a relation active triple resource with an id, label and url' do
    @obj = ExampleWork.new
    @obj.attributes = {
      relation_attributes: [
        {
          label: 'A relation label',
          url: 'http://example.com/relation'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.relation.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.relation.first.id).to include('#relation')
    expect(@obj.relation.first.label).to eq ['A relation label']
    expect(@obj.relation.first.url).to eq ['http://example.com/relation']
  end
end
