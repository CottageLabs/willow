require 'rails_helper'

describe DateStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :date, predicate: ::RDF::Vocab::DC.date, class_name:"DateStatement"
      accepts_nested_attributes_for :date
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a date active triple resource with an date and description' do
    @obj = ExampleWork.new
    @obj.attributes = {
      date_attributes: [
        {
          date: '2017-01-02',
          description: 'A description of the date',
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.date.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.date.first.id).to include('#date')
    expect(@obj.date.first.date).to eq ['2017-01-02']
    expect(@obj.date.first.description).to eq ['A description of the date']
  end

  it 'defines qualifiers' do
    expect(DateStatement.qualifiers).to be_kind_of Hash
    expect(DateStatement.qualifiers).not_to be_empty
  end
end