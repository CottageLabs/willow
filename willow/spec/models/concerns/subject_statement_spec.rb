require 'rails_helper'

RSpec.describe SubjectStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :subject_nested, predicate: ::RDF::Vocab::DC.subject, class_name:"SubjectStatement"
      accepts_nested_attributes_for :subject_nested
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a subject active triple resource with an id, label and url' do
    @obj = ExampleWork.new
    @obj.attributes = {
      subject_nested_attributes: [
        {
          label: 'A subject label',
          definition: 'The definition of the subject',
          classification: 'LCSH',
          homepage: 'http://example.com/lcsh'
        }
      ]
    }
    expect(@obj.subject_nested.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.subject_nested.first.label).to eq ['A subject label']
    expect(@obj.subject_nested.first.definition).to eq ['The definition of the subject']
    expect(@obj.subject_nested.first.classification).to eq ['LCSH']
    expect(@obj.subject_nested.first.homepage).to eq ['http://example.com/lcsh']
  end

  it 'has the correct uri' do
    skip "Error initializing URI"
    @obj = ExampleWork.new
    @obj.attributes = {
      subject_nested_attributes: [
        {
          label: 'A subject label',
          definition: 'The definition of the subject',
          classification: 'LCSH',
          homepage: 'http://example.com/lcsh'
        }
      ]
    }
    expect(@obj.subject_nested.first.id).to include('#subject')
  end
end
