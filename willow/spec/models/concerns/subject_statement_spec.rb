require 'rails_helper'

describe SubjectStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :subject, predicate: ::RDF::Vocab::DC.subject, class_name:"SubjectStatement"
      accepts_nested_attributes_for :subject
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a subject active triple resource with an id, label and url' do
    @obj = ExampleWork.new
    @obj.attributes = {
      subject_attributes: [
        {
          label: 'A subject label',
          definition: 'The definition of the subject',
          classification: 'LCSH',
          homepage: 'http://example.com/lcsh'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.subject.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.subject.first.id).to include('#subject')
    expect(@obj.subject.first.label).to eq ['A subject label']
    expect(@obj.subject.first.definition).to eq ['The definition of the subject']
    expect(@obj.subject.first.classification).to eq ['LCSH']
    expect(@obj.subject.first.homepage).to eq ['http://example.com/lcsh']
  end
end
