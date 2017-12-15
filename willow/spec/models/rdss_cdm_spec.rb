# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'

RSpec.describe RdssCdm do
  it 'has human readable type rdss_cdm' do
    @obj = build(:rdss_cdm)
    expect(@obj.human_readable_type).to eq('RDSS CDM')
  end

  describe 'title' do
    it 'requires title' do
      @obj = build(:rdss_cdm, title: nil)
      #@obj.save!
      expect{@obj.save!}.to raise_error(ActiveFedora::RecordInvalid, 'Validation failed: Title Your work must have a title.')
    end

    it 'has a multi valued title field' do
      @obj = build(:rdss_cdm, title: ['test rdss_cdm'])
      expect(@obj.title).to eq ['test rdss_cdm']
    end
  end


  describe 'version' do
    it 'has a version' do
      @obj = build(:rdss_cdm, object_version: ['version'])
      expect(@obj.object_version).to eq ['version']
    end

    it 'indexes version' do
      skip # TODO: unskip when indexing implemented
      @obj = build(:rdss_cdm, object_version: ['version'])
      @doc = @obj.to_solr
      expect(@doc['object_version_tesim']).to eq ['version']
    end
  end

  # single valued
  describe 'uuid' do
    it 'has uuid' do
      @obj = build(:rdss_cdm, object_uuid: 'uuid')
      expect(@obj.object_uuid).to eq 'uuid'
    end

    it 'indexes uuid' do
      skip # TODO: unskip when indexing implemented
      @obj = build(:rdss_cdm, object_uuid: 'uuid')
      @doc = @obj.to_solr
      expect(@doc['object_uuid_tesim']).to eq ['uuid']
    end
  end

  describe 'description' do
    it 'has description' do
      @obj = build(:rdss_cdm, object_description: 'description')
      expect(@obj.object_description).to eq 'description'
    end

    it 'indexes description' do
      skip # TODO: unskip when indexing implemented
      @obj = build(:rdss_cdm, object_description: ['description'])
      @doc = @obj.to_solr
      expect(@doc['object_description_tesim']).to eq ['description']
    end
  end

  describe 'keywords' do
    it 'has keywords' do
      @obj = build(:rdss_cdm, object_keywords: ['keywords'])
      expect(@obj.object_keywords).to eq ['keywords']
    end

    it 'indexes keywords' do
      skip # TODO: unskip when indexing implemented
      @obj = build(:rdss_cdm, object_keywords: ['keywords'])
      @doc = @obj.to_solr
      expect(@doc['object_keywords_tesim']).to eq ['keywords']
    end
  end

  describe 'category' do
    it 'has category' do
      @obj = build(:rdss_cdm, object_category: ['category'])
      expect(@obj.object_category).to eq ['category']
    end

    it 'indexes category' do
      skip # TODO: unskip when indexing implemented
      @obj = build(:rdss_cdm, object_category: ['category'])
      @doc = @obj.to_solr
      expect(@doc['object_category_tesim']).to eq ['category']
    end
  end

  
end
