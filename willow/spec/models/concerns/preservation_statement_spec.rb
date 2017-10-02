require 'rails_helper'

RSpec.describe PreservationStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :preservation_nested, predicate: ::RDF::Vocab::PREMIS.hasEvent, class_name:"PreservationStatement"
      accepts_nested_attributes_for :preservation_nested
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a preservation active triple resource with an id and all properties' do
    @obj = ExampleWork.new
    @obj.attributes = {
      preservation_nested_attributes: [
        {
          name: 'Foo Bar',
          event_type: 'Baz',
          date: '2017-04-01 10:23:45',
          description: 'Event description',
          outcome: 'Success'
        }
      ]
    }
    expect(@obj.preservation_nested.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.preservation_nested.first.name).to eq ['Foo Bar']
    expect(@obj.preservation_nested.first.event_type).to eq ['Baz']
    expect(@obj.preservation_nested.first.date).to eq ['2017-04-01 10:23:45']
    expect(@obj.preservation_nested.first.description).to eq ['Event description']
    expect(@obj.preservation_nested.first.outcome).to eq ['Success']
  end

  it 'has the correct uri' do
    @obj = ExampleWork.new
    @obj.attributes = {
      preservation_nested_attributes: [{
        name: 'Foo Bar',
        event_type: 'Baz',
      }]
    }
    expect(@obj.preservation_nested.first.id).to include('#preservation')
  end
end
