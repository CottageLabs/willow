# Generated via
#  `rails generate curation_concerns:work Dataset`
require 'rails_helper'

RSpec.describe Dataset do
  it 'has human readable type dataset' do
    @obj = Dataset.new
    @obj.attributes = {
      title: ['test dataset']
    }
    @obj.save!
    @obj.reload
    expect(@obj.human_readable_type).to eq('Dataset')
  end

  it 'requires title' do
    @obj = Dataset.new
    expect { @obj.save! }.to raise_error
      ('ActiveFedora::RecordInvalid: Validation failed: Title Your work must have a title.')
  end

  describe 'nested attributes for license' do
    it 'accepts license attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        license_attributes: [{
            label: 'A license label',
            definition: 'A definition of the license',
            webpage: 'http://example.com/license'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.license.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.license.first.id).to include('#license')
      expect(@obj.license.first.label).to eq ['A license label']
      expect(@obj.license.first.definition).to eq ['A definition of the license']
      expect(@obj.license.first.webpage).to eq ['http://example.com/license']
    end

    it 'rejects lcense attributes if all blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        license_attributes: [{
            label: '',
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.license.size).to eq(0)
    end

    it 'destroys license' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        license_attributes: [{
            label: 'test label'
          }]
      }
      @obj.save!
      @obj.reload
      @obj.attributes = {
        license_attributes: [{
            id: @obj.license.first.id,
            label: 'test label',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.license.size).to eq(0)
    end

    it 'indexes the license' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        license_attributes: [{
            label: 'A license label',
            definition: 'A definition of the license',
            webpage: 'http://example.com/license'
          }]
      }
      @doc = @obj.to_solr
      expect(@doc['license_sim']).to eq ['A license label']
      expect(@doc).to include('license_tesim')
    end
  end

  describe 'nested attributes for creator' do
    it 'accepts person attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        creator_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          },
          {
            last_name: 'Hello world',
            orcid: '0001-0001-0001-0001',
            role: 'Author'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator.size).to eq(2)
      expect(@obj.creator[0]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator[0].id).to include('#person')
      expect(@obj.creator[1]).to be_kind_of ActiveTriples::Resource
      expect(@obj.creator[1].id).to include('#person')
    end

    it 'rejects person if blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        creator_attributes: [{
            first_name: 'Foo',
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator.size).to eq(0)
    end

    it 'destroys creator' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        creator_attributes: [{
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator.size).to eq(1)
      @obj.attributes = {
        creator_attributes: [{
            id: @obj.creator.first.id,
            first_name: 'Foo',
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.creator.size).to eq(0)
    end

    it 'indexes the creator' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        creator_attributes: [{
            first_name: ['Foo'],
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }]
      }
      @doc = @obj.to_solr
      expect(@doc['creator_sim']).to eq ['Foo Bar']
      expect(@doc['creator_tesim']).to eq ['Foo Bar']
      expect(@doc).to include('person_tesim')
    end
  end

  describe 'nested attributes for relation' do
    it 'accepts relation attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        relation_attributes: [
          {
            label: 'A relation label',
            url: 'http://example.com/relation'
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq 1
      expect(@obj.relation.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.relation.first.id).to include('#relation')
      expect(@obj.relation.first.label).to eq ['A relation label']
      expect(@obj.relation.first.url).to eq ['http://example.com/relation']
    end

    it 'rejectss relation if blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        relation_attributes: [
          {
            label: 'Test label'
          },
          {
            label: '',
            url: nil,
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq(0)
    end

    it 'destroys relation' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        relation_attributes: [{
            label: 'test label',
            url: 'http://example.com/relation'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq(1)
      @obj.attributes = {
        relation_attributes: [{
            id: @obj.relation.first.id,
            label: 'test label',
            url: 'http://example.com/relation',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.relation.size).to eq(0)
    end

    it 'indexes relation' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        relation_attributes: [{
          label: 'test label',
          url: 'http://example.com/relation'
        }]
      }
      @doc = @obj.to_solr
      expect(@doc['relation_tesim']).to eq ['http://example.com/relation']
    end
  end

  describe 'nested attributes for publication' do
    it 'accepts publication attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        publication_attributes: [
          {
            title: 'A publication title',
            journal: 'A journal for the publication',
            url: 'http://example.com/publication'
          }
        ]
      }
      @obj.save!
      @obj.reload
      expect(@obj.publication.size).to eq 1
      expect(@obj.publication.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.publication.first.id).to include('#publication')
      expect(@obj.publication.first.title).to eq ['A publication title']
      expect(@obj.publication.first.journal).to eq ['A journal for the publication']
      expect(@obj.publication.first.url).to eq ['http://example.com/publication']
    end

    it 'rejects publication if all blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        publication_attributes: [
          {
            title: 'Test title'
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        publication_attributes: [{
            title: 'test title',
            url: 'http://example.com/publication'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.publication.size).to eq(1)
      @obj.attributes = {
        publication_attributes: [{
            id: @obj.publication.first.id,
            title: 'test title',
            url: 'http://example.com/publication',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.publication.size).to eq(0)
    end

    it 'indexes publication' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        publication_attributes: [{
          title: 'test title',
          journal: 'A journal for the publication',
          url: 'http://example.com/publication'
        }]
      }
      @doc = @obj.to_solr
      expect(@doc['publication_tesim']).to eq ['test title']
      expect(@doc['journal_sim']).to eq ['A journal for the publication']
      expect(@doc['journal_tesim']).to eq ['A journal for the publication']
    end
  end

  describe 'nested attributes for admin_metadata' do
    it 'accepts admin_metadata attributes' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        admin_metadata_attributes: [{
          question: 'An admin question needing an answer',
          response: 'Response to admin question'
        }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.admin_metadata.size).to eq(1)
      expect(@obj.admin_metadata.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.admin_metadata.first.id).to include('#admin_metadata')
      expect(@obj.admin_metadata.first.question).to eq ['An admin question needing an answer']
      expect(@obj.admin_metadata.first.response).to eq 'Response to admin question']
    end

    it 'rejects publication if all blank' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        publication_attributes: [
          {
            title: 'Test title'
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
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test title'],
        publication_attributes: [{
            title: 'test title',
            url: 'http://example.com/publication'
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.publication.size).to eq(1)
      @obj.attributes = {
        publication_attributes: [{
            id: @obj.publication.first.id,
            title: 'test title',
            url: 'http://example.com/publication',
            _destroy: "1"
          }]
      }
      @obj.save!
      @obj.reload
      expect(@obj.publication.size).to eq(0)
    end

    it 'indexes publication' do
      @obj = Dataset.new
      @obj.attributes = {
        title: ['test dataset'],
        publication_attributes: [{
          title: 'test title',
          journal: 'A journal for the publication',
          url: 'http://example.com/publication'
        }]
      }
      @doc = @obj.to_solr
      expect(@doc['publication_tesim']).to eq ['test title']
      expect(@doc['journal_sim']).to eq ['A journal for the publication']
      expect(@doc['journal_tesim']).to eq ['A journal for the publication']
    end
  end

end
