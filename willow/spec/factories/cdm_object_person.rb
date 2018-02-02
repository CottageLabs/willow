FactoryGirl.define do

  factory :cdm_object_person, class: 'Cdm::ObjectPerson' do
    title ['Person']
    access_control
    skip_create
    override_new_record
  end

  factory :person_seq, class: CDM::ObjectPerson do
    sequence(:name) {|n| ["name #{n}"] }
  end
end
