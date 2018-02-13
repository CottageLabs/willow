require 'rails_helper'

RSpec.describe Cdm::Identifier do
  # since this is a model, we just check it can build the correct fields

  describe 'identifier value' do
    it 'has an identifier value' do
      obj = build(:cdm_identifier, identifier_value: 'test identifier value')
      expect(obj.identifier_value).to be_kind_of String
      expect(obj.identifier_value).to eq 'test identifier value'
    end
  end

  describe 'identifier type' do
    it 'has an identifier type' do
      obj = build(:cdm_identifier, identifier_type: 'URL')
      expect(obj.identifier_type).to be_kind_of String
      expect(obj.identifier_type).to eq 'URL'
    end
  end
end