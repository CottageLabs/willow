# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'

RSpec.describe Hyrax::RdssCdmForm do
  describe 'permitted params' do
    subject { described_class.permitted_params }

    it 'permits :admin_set_id' do
      expect(subject.include?(:admin_set_id)).to be_truthy
    end

    it 'permits :visibility' do
      expect(subject.include?(:visibility)).to be_truthy
    end

    it 'permits :visibility_during_embargo' do
      expect(subject.include?(:visibility_during_embargo)).to be_truthy
    end

    it 'permits :visibility_after_embargo' do
      expect(subject.include?(:visibility_after_embargo)).to be_truthy
    end

    it 'permits :visibility_during_lease' do
      expect(subject.include?(:visibility_during_lease)).to be_truthy
    end

    it 'permits :visibility_after_lease' do
      expect(subject.include?(:visibility_after_lease)).to be_truthy
    end

    it 'permits :embargo_release_date' do
      expect(subject.include?(:embargo_release_date)).to be_truthy
    end

    it 'permits :member_of_collection_ids' do
      expect(subject.include?(:member_of_collection_ids)).to be_truthy
    end
  end
end
