FactoryGirl.define do

  factory :organisation do
    title ["Organisation"]
    access_control
    skip_create
    override_new_record
  end


  factory :organisation_seq, class: Organisation do
    sequence(:id) {|n| "organisation-#{n}"}
    sequence(:org_name) {|n| ["name #{n}"] }
  end
end
