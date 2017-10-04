FactoryGirl.define do

  factory :project do
    title ["Project"]
    access_control
    skip_create
    override_new_record
  end


  factory :project_seq, class: Project do
    sequence(:id) {|n| "project-#{n}"}
    sequence(:title) {|n| ["Project #{n}"] }
  end
end
