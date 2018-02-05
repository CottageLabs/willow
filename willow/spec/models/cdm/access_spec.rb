require 'rails_helper'

RSpec.describe Cdm::Access do
  # since this is a model, we just check it can build the correct fields

  describe 'access statement' do
    it 'has an access statement' do
      @obj = build(:cdm_access, access_statement: 'test access statement')
      expect(@obj.access_statement).to be_kind_of String
      expect(@obj.access_statement).to eq 'test access statement'
    end
  end

  describe 'access type' do
    it 'has an access type' do
      @obj = build(:cdm_access, access_type: 'controlled')
      expect(@obj.access_type).to be_kind_of String
      expect(@obj.access_type).to eq 'controlled'
    end
  end
end