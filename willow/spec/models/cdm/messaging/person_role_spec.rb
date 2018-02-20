require 'rails_helper'

# Note that there is no file person_role.rb for this class. It is generated from ::Cdm::Messaging::Enumerations
# by the line that effectively translates to:
# Cdm::Messaging::Enumerations.const_set('personRole'.classify, Decoder.('personRole'))

RSpec.describe ::Cdm::Messaging::Enumerations::PersonRole do
  describe 'enumerated values should be class methods returning integers as strings' do
    it 'should return 1 for #administrator' do
      expect(described_class.administrator).to eq 1
    end

    it 'should return 5 for #data_creator' do
      expect(described_class.data_creator).to eq 5
    end

    it 'should raise an exception if called the with class method of a different enumerator' do
      expect{described_class.safeguarded}.to raise_error(NoMethodError, /undefined method `safeguarded' for #{described_class.name}:Class/ )
    end
  end
end