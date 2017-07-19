FactoryGirl.define do
  factory :work, aliases: [:private_work], class: Work do

    transient do
      user { FactoryGirl.create(:user) }
      content nil
    end

    title ['Work title']
    id 'W-00000000'


    access_control
    skip_create
    override_new_record


    after(:build) do |work, evaluator|
      work.apply_depositor_metadata(evaluator.user.user_key)
    end

    factory :work_with_one_file do
      before(:create) do |work, evaluator|
        work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user, title: ['A Contained FileSet'])
      end
    end
  end
end
