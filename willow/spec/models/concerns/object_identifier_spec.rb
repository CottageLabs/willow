require 'rails_helper'

RSpec.describe ObjectIdentifier, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :identifier_nested, predicate: ::RDF::Vocab::DC.identifier, class_name:"ObjectIdentifier"
      accepts_nested_attributes_for :identifier_nested
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates an object identifier active triple resource with an id, label and value' do
    @obj = ExampleWork.new
    @obj.attributes = {
      identifier_nested_attributes: [{
          obj_id_scheme: 'ISBN',
          obj_id: '123456'
        }]
    }
    expect(@obj.identifier_nested.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.identifier_nested.first.obj_id_scheme).to eq ['ISBN']
    expect(@obj.identifier_nested.first.obj_id).to eq ['123456']
  end

  it 'has the correct uri' do
    @obj = ExampleWork.new
    @obj.attributes = {
      identifier_nested_attributes: [{
          obj_id_scheme: 'ISBN',
          obj_id: '123456'
        }]
    }
    expect(@obj.identifier_nested.first.id).to include('#identifier')
  end
end
