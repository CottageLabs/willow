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

    it 'reject person if blank' do
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
            first_name: ['Foo', 'Baz'],
            last_name: 'Bar',
            orcid: '0000-0000-0000-0000',
            role: 'Author'
          }]
      }
      @doc = @obj.to_solr
      expect(@doc['creator_sim']).to eq ['Foo Baz Bar']
      expect(@doc['creator_tesim']).to eq ['Foo Baz Bar']
      expect(@doc).to include('person_tesim')
    end
  end

end
