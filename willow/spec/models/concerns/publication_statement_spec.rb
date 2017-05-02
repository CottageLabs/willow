require 'rails_helper'

describe PublicationStatement do
  before do
    class ExampleWork < ActiveFedora::Base
      property :publication, predicate: ::RDF::Vocab::DC.isReferencedBy, class_name:"PublicationStatement"
      accepts_nested_attributes_for :publication, reject_if: :all_blank, allow_destroy: true
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

  it 'rejects attributes if all blank' do
    @obj = ExampleWork.new
    @obj.attributes = {
      publication_attributes: [
        {
          title: 'Related Publication Title'
        },
        {
          title: '',
          url: nil,
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.publication.size).to eq(1)
  end

  it 'destroys publication' do
    @obj = ExampleWork.new
    @obj.attributes = {
      publication_attributes: [
        {
          title: 'Related Publication Title',
          url: 'http://example.com/publication'
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.publication.size).to eq(1)
    @obj.attributes = {
      publication_attributes: [
        {
          id: @obj.publication.first.id,
          title: 'Related Publication Title',
          url: 'http://example.com/publication',
          _destroy: "1"
        }
      ]
    }
    @obj.save!
    @obj.reload
    expect(@obj.publication.size).to eq(0)
  end

end
