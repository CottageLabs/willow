require 'rails_helper'

RSpec.describe Cdm::IdentifierRelationship do

  describe 'related type' do
    it 'has a related type' do
      obj = build(:cdm_identifier_relationship, related_type: 'cited')
      expect(obj.identifier_type).to be_kind_of String
      expect(obj.identifier_type).to eq 'cited'
    end
  end

  describe 'nested attributes for identifier' do
    it 'accepts identifier attributes' do
      obj = build(:cdm_identifier_relationship, identifier_attributes: [{ identifier_type: 'URL', identifier_value: 'http://example.com' }])
      expect(obj.identifier).to be_kind_of ActiveFedora::Base
      expect(obj.identifier.identifier_type).to eq 'URL'
      expect(obj.identifier.identifier_value).to eq 'http://example.com'
    end
  end
end
