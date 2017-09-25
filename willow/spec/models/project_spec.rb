require 'rails_helper'

RSpec.describe Project, :vcr do
  describe 'class'  do
    it 'has human readable type project' do
      @obj = build(:project)
      expect(@obj.human_readable_type).to eq('Project')
    end
  end

  describe 'title' do
    it 'has a title' do
      @obj = build(:project, title: ['Project title'])
      expect(@obj.title).to be_kind_of ActiveTriples::Relation
      expect(@obj.title).to eq ['Project title']
    end

    it 'indexes title' do
      @obj = build(:project, title: ['Project title'])
      @doc = @obj.to_solr
      expect(@doc['title_tesim']).to eq(['Project title'])
    end
  end

  describe 'description' do
    it 'has a description' do
      @obj = build(:project, description: ['Project description'])
      expect(@obj.description).to be_kind_of ActiveTriples::Relation
      expect(@obj.description).to eq ['Project description']
    end

    it 'indexes description' do
      @obj = build(:project, description: ['Project description'])
      @doc = @obj.to_solr
      expect(@doc['description_tesim']).to eq(['Project description'])
    end
  end

  describe 'start_date' do
    it 'has a start_date' do
      @obj = build(:project, start_date: ['21-01-2017'])
      expect(@obj.start_date).to be_kind_of ActiveTriples::Relation
      expect(@obj.start_date).to eq ['21-01-2017']
    end

    it 'indexes start_date' do
      @obj = build(:project, start_date: ['21-01-2017'])
      @doc = @obj.to_solr
      expect(@doc['start_date_dtsim']).to eq(['2017-01-21T00:00:00Z'])
      expect(@doc['start_date_ssi']).to eq('21-01-2017')
    end
  end

  describe 'end_date' do
    it 'has a end_date' do
      @obj = build(:project, end_date: ['21-02-2017'])
      expect(@obj.end_date).to be_kind_of ActiveTriples::Relation
      expect(@obj.end_date).to eq ['21-02-2017']
    end

    it 'indexes end_date' do
      @obj = build(:project, end_date: ['21-02-2017'])
      @doc = @obj.to_solr
      expect(@doc['end_date_dtsim']).to eq(['2017-02-21T00:00:00Z'])
      expect(@doc['end_date_ssi']).to eq('21-02-2017')
    end
  end

  describe 'nested attributes for identifier_object' do
    it 'accepts identifier object attributes' do
      @obj = build(:project, identifier_nested_attributes: [{
          obj_id_scheme: 'ORCID',
          obj_id: '123456'
        }]
      )
      expect(@obj.identifier_nested.size).to eq(1)
      expect(@obj.identifier_nested.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.identifier_nested.first.obj_id_scheme).to eq ['ORCID']
      expect(@obj.identifier_nested.first.obj_id).to eq ['123456']
    end

    it 'has the correct uri' do
      @obj = build(:project, identifier_nested_attributes: [{
          obj_id_scheme: 'ORCID',
          obj_id: '123456'
        }]
      )
      expect(@obj.identifier_nested.first.id).to include('#identifier')
    end

    it 'rejects attributes if scheme or id are blank' do
      @obj = build(:project, identifier_nested_attributes: [
          {
            obj_id_scheme: 'ORCID'
          },
          {
            obj_id: '123456'
          },
          {
            obj_id_scheme: '',
            obj_id: nil
          },
          {
            obj_id_scheme: 'ORCID',
            obj_id: '123456'
          }]
      )
      expect(@obj.identifier_nested.size).to eq(1)
    end

    it 'destroys identifier object' do
      @obj = build(:project, identifier_nested_attributes: [{
            obj_id_scheme: 'ORCID',
            obj_id: '123456'
          }]
      )
      expect(@obj.identifier_nested.size).to eq(1)
      @obj.attributes = {
        identifier_nested_attributes: [{
            id: @obj.identifier_nested.first.id,
            obj_id_scheme: 'ORCID',
            obj_id: '123456',
            _destroy: "1"
          }]
      }
      expect(@obj.identifier_nested.size).to eq(0)
    end

    it 'indexes the identifier object' do
      @obj = build(:project, identifier_nested_attributes: [{
            obj_id_scheme: 'ORCID',
            obj_id: '123456'
        }, {
            obj_id_scheme: 'ARK',
            obj_id: '1dfsdfsd56'
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('identifier_nested_ssim')
      expect(@doc).to include('identifier_nested_ssm')
      expect(@doc['identifier_orcid_ssim']).to match_array(['123456'])
      expect(@doc['identifier_ark_ssim']).to match_array(['1dfsdfsd56'])
    end
  end

end
