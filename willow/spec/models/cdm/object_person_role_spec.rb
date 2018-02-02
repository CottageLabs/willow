require 'rails_helper'

RSpec.describe Cdm::ObjectPersonRole do
  # since this is a model, we just check it can build the correct fields
  describe 'role_type' do
    it 'has multiple role_types' do
      @obj = build(:cdm_object_person_role, role_type: ['author','reviewer'])
      expect(@obj.role_type).to be_kind_of Array
      expect(@obj.role_type).to eq 'created'
    end
  end
end