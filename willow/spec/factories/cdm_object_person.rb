FactoryGirl.define do

  factory :cdm_object_person, class: "Cdm::ObjectPerson" do
    skip_create
    override_new_record
  end
end
