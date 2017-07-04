require 'rails_helper'

RSpec.describe AdministrativeStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :admin_metadata, predicate: ::RDF::Vocab::MODS.adminMetadata, class_name:"AdministrativeStatement"
      accepts_nested_attributes_for :admin_metadata
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates an admin metadata active triple resource with an id, question and response' do
    @obj = ExampleWork.new
    @obj.attributes = {
      admin_metadata_attributes: [{
          question: 'An admin question needing an answer',
          response: 'Response to admin question'
        }]
    }
    expect(@obj.admin_metadata.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.admin_metadata.first.id).to include('#admin_metadata')
    expect(@obj.admin_metadata.first.question).to eq ['An admin question needing an answer']
    expect(@obj.admin_metadata.first.response).to eq ['Response to admin question']
  end
end
