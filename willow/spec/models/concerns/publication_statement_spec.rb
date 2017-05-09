require 'rails_helper'

describe PublicationStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :publication, predicate: ::RDF::Vocab::DC.isReferencedBy, class_name:"PublicationStatement"
      accepts_nested_attributes_for :publication
    end
  end
  after do
    Object.send(:remove_const, :ExampleWork)
  end

  it 'creates a publication active triple resource with an id, title, url, and journal' do
    @obj = ExampleWork.new
    @obj.attributes = {
      publication_attributes: [
        {
          title: 'A publication title',
          url: 'http://example.com/publication',
          journal: 'Test journal for publication'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.publication.first).to be_kind_of ActiveTriples::Resource
    expect(@obj.publication.first.id).to include('#publication')
    expect(@obj.publication.first.title).to eq ['A publication title']
    expect(@obj.publication.first.url).to eq ['http://example.com/publication']
    expect(@obj.publication.first.journal).to eq ['Test journal for publication']
  end
end
