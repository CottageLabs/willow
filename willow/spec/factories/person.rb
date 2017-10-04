FactoryGirl.define do

  factory :person do
    title ["Person"]
    access_control
    skip_create
    override_new_record
  end


  factory :person_seq, class: Person do
    sequence(:id) {|n| "person-#{n}"}
    sequence(:name) {|n| ["name #{n}"] }
  end
end
