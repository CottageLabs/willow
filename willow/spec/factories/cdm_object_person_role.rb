FactoryGirl.define do

  factory :cdm_object_person_role, :class => 'Cdm::ObjectPersonRole' do
    skip_create
    override_new_record
  end

end
