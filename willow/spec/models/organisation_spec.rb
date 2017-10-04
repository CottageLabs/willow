require 'rails_helper'

RSpec.describe Organisation, :vcr do
  describe 'class'  do
    it 'has human readable type organisation' do
      @obj = build(:organisation)
      expect(@obj.human_readable_type).to eq('Organisation')
    end
  end

  describe 'name' do
    it 'has a org_name' do
      @obj = build(:organisation, org_name: ['Paddington and Company'])
      expect(@obj.org_name).to be_kind_of ActiveTriples::Relation
      expect(@obj.org_name).to eq ['Paddington and Company']
    end

    it 'indexes org_name' do
      @obj = build(:organisation, org_name: ['Paddington and Company'])
      @doc = @obj.to_solr
      expect(@doc['org_name_tesim']).to eq(['Paddington and Company'])
      expect(@doc['org_name_sim']).to eq(['Paddington and Company'])
    end
  end

  describe 'type' do
    it 'has a org_type' do
      @obj = build(:organisation, org_type: ['Creator'])
      expect(@obj.org_type).to be_kind_of ActiveTriples::Relation
      expect(@obj.org_type).to eq ['Creator']
    end

    it 'indexes org_type' do
      @obj = build(:organisation, org_type: ['Creator'])
      @doc = @obj.to_solr
      expect(@doc['org_type_tesim']).to eq(['Creator'])
      expect(@doc['org_type_sim']).to eq(['Creator'])
    end
  end

  describe 'nested attributes for identifier_object' do
    it 'accepts identifier object attributes' do
      @obj = build(:organisation, identifier_nested_attributes: [{
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
      @obj = build(:organisation, identifier_nested_attributes: [{
          obj_id_scheme: 'ORCID',
          obj_id: '123456'
        }]
      )
      expect(@obj.identifier_nested.first.id).to include('#identifier')
    end

    it 'rejects attributes if scheme or id are blank' do
      @obj = build(:organisation, identifier_nested_attributes: [
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
      @obj = build(:organisation, identifier_nested_attributes: [{
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
      @obj = build(:organisation, identifier_nested_attributes: [{
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

  describe 'nested attributes for contact' do
    it 'accepts contact attributes' do
      @obj = build(:organisation, contact_nested_attributes: [{
          label: ['home'],
          email: ['paddington.brown@example.com'],
          address: ['32 Windsor Gardens, London'],
          telephone: ['01234567890']
        }]
      )
      expect(@obj.contact_nested.size).to eq(1)
      expect(@obj.contact_nested.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.contact_nested.first.label).to eq ['home']
      expect(@obj.contact_nested.first.email).to eq ['paddington.brown@example.com']
      expect(@obj.contact_nested.first.address).to eq ['32 Windsor Gardens, London']
      expect(@obj.contact_nested.first.telephone).to eq ['01234567890']
    end

    it 'has the correct uri' do
      @obj = build(:organisation, contact_nested_attributes: [{
          label: 'home',
          email: 'paddington.brown@example.com'
        }]
      )
      expect(@obj.contact_nested.first.id).to include('#contact')
    end

    it 'rejects attributes if email, address and telephone are blank' do
      @obj = build(:organisation, contact_nested_attributes: [
          {
            telephone: nil,
            email: '',
            address: ''
          },
          {
            email: 'paddington.company@example.com'
          },
          {
            telephone: '01234567890'
          },
          {
            address: '32 Windsor Gardens, London',
          },
          {
            label: 'home',
            telephone: '01234567891',
            email: 'paddington.org@example.com',
            address: '32 Windsor Gardens'
          }]
      )
      expect(@obj.contact_nested.size).to eq(4)
    end

    it 'destroys contact object' do
      @obj = build(:organisation, contact_nested_attributes: [{
          label: 'home',
          email: 'paddington.company@example.com'
        }]
      )
      expect(@obj.contact_nested.size).to eq(1)
      @obj.attributes = {
        contact_nested_attributes: [{
            id: @obj.contact_nested.first.id,
            label: 'home',
            email: 'paddington.company@example.com',
            _destroy: "1"
          }]
      }
      expect(@obj.contact_nested.size).to eq(0)
    end

    it 'indexes the contact object' do
      @obj = build(:organisation, contact_nested_attributes: [{
          email: ['paddington.company@example.com']
        },{
          telephone: '01234567890'
        },{
          address: '32 Windsor Gardens, London',
        },{
          label: 'home',
          telephone: '01234567891',
          email: 'paddington.org@example.com',
          address: 'London, UK'
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('contact_nested_ssm')
      expect(@doc['contact_email_tesim']).to match_array(['paddington.company@example.com', 'paddington.org@example.com'])
      expect(@doc['contact_telephone_ssim']).to match_array(['01234567890','01234567891'])
      expect(@doc['contact_address_tesim']).to match_array(['32 Windsor Gardens, London','London, UK'])
    end
  end

end
