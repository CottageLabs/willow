require 'rails_helper'

RSpec.describe Cdm::Date, :vcr do
  before :all do
    class ExampleWork < ActiveFedora::Base
      property :object_date, predicate: ::RDF::Vocab::DC11.date, class_name: "Cdm::Date"
      accepts_nested_attributes_for :object_date
    end
  end

  after :all do
    Object.send(:remove_const, :ExampleWork)
  end

  let(:date_type) { 'copyrighted' }
  let(:date_value) { '10/02/2018' }
  let(:attributes) do
    {
      object_date_attributes: [
        {
          date_type: date_type,
          date_value: date_value
        }
      ]
    }
  end

  before :each do
    @obj = ExampleWork.new
    @obj.attributes = attributes
  end

  it 'creates an ObjectDate element of kind ActiveTriple::Resource' do
    expect(@obj.object_date[0]).to be_kind_of ActiveTriples::Resource
  end

  it 'creates the correct date type property' do
    expect(@obj.object_date[0].date_type).to eq([date_type])
  end

  it 'creates the correct date value property' do
    expect(@obj.object_date[0].date_value).to eq([date_value])
  end

  it 'has the correct uri' do
    expect(@obj.object_date[0].id).to include('#object_date')
  end
end