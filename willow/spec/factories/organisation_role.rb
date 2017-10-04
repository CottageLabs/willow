FactoryGirl.define do

  factory :organisation_role do
    access_control
    skip_create
    override_new_record
  end
end
