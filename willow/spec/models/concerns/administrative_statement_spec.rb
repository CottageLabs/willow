require 'rails_helper'

describe AdministrativeStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :admin_metadata, predicate: ::RDF::Vocab::MODS.adminMetadata, class_name:"AdministrativeStatement"
      accepts_nested_attributes_for :admin_metadata, reject_if: proc { |attributes|
       Array(attributes[:question]).all?(&:blank?) }, allow_destroy: true
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
    @obj.save!
    @obj.reload
    expect(@obj.admin_metadata.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.admin_metadata.first.id).to include('#admin_metadata')
    expect(@obj.admin_metadata.first.question).to eq ['An admin question needing an answer']
    expect(@obj.admin_metadata.first.response).to eq 'Response to admin question']
  end

  it 'rejects attributes if question blank' do
    @obj = ExampleWork.new
    @obj.attributes = {
      admin_metadata_attributes: [
        {
          question: 'An admin question needing an answer'
        },
        {
          response: 'a response'
        },
        {
          question: '',
          response: nil
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.admin_metadata.size).to eq(1)
  end

  it 'destroys admin_metadata' do
    @obj = ExampleWork.new
    @obj.attributes = {
      admin_metadata_attributes: [
        {
          question: 'An admin question needing an answer',
          response: 'Response to admin question'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.admin_metadata.size).to eq(1)
    @obj.attributes = {
      admin_metadata_attributes: [
        {
          id: @obj.admin_metadata.first.id,
          question: 'An admin question needing an answer',
          response: 'Response to admin question'
          _destroy: "1"
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.admin_metadata.size).to eq(0)
  end
end
