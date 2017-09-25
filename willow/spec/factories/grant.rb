FactoryGirl.define do

  factory :grant do
    title ["Grant"]
    access_control
    skip_create
    override_new_record
  end


  factory :grant_seq, class: Grant do
    sequence(:id) {|n| "grant-#{n}"}
    sequence(:title) {|n| ["Grant #{n}"] }
  end
end
