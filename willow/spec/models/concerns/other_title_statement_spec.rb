require 'rails_helper'

RSpec.describe OtherTitleStatement, :vcr do
  before do
    class ExampleWork < ActiveFedora::Base
      property :other_title, predicate: ::RDF::Vocab::Bibframe.titleVariation, class_name:"OtherTitleStatement"
      accepts_nested_attributes_for :other_title
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates an other titles active triple resource with a title and type' do
    @obj = ExampleWork.new
    @obj.attributes = {
      other_title_attributes: [
        {
          title: 'An alternate title',
          title_type: 'Alternate'
        }
      ]
    }
    expect(@obj.other_title.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.other_title.first.title).to eq ['An alternate title']
    expect(@obj.other_title.first.title_type).to eq ['Alternate']
  end

  it 'has the correct uri' do
    skip "Error initializing URI"
    @obj = ExampleWork.new
    @obj.attributes = {
      other_title_attributes: [
        {
          title: 'An alternate title',
          title_type: 'Alternate'
        }
      ]
    }
    expect(@obj.other_title.first.id).to include('#title')
  end
end
