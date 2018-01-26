FactoryGirl.define do

  factory :cdm_access, :class => 'Cdm::Access' do
    skip_create
    override_new_record
  end

end
