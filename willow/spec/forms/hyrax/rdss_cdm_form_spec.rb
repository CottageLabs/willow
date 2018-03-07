# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'

RSpec.describe Hyrax::RdssCdmForm do
  describe 'permitted params' do
    subject { described_class.permitted_params }

    it 'permits :visibility' do
      expect(subject.include?(:visibility)).to be_truthy
    end
  end
end
