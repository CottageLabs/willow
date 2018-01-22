require 'rails_helper'

RSpec.describe Cdm::Date, :vcr do
  # since this is a model, we just check it can build the correct fields
  describe 'date_type' do
    it 'has a single valued date_type' do
      @obj = build(:cdm_date, date_type: 'created')
      expect(@obj.date_type).to be_kind_of String
      expect(@obj.date_type).to eq 'created'
    end

    it 'has a single valued date_value' do
      @obj = build(:cdm_date, date_value: '10/18/2018')
      expect(@obj.date_value).to be_kind_of String
      expect(@obj.date_value).to eq '10/18/2018'
    end
  end
end