FactoryGirl.define do
  factory :book, aliases: [:private_book], class: Book do

    transient do
      user { FactoryGirl.create(:user) }
      content nil
    end

    title ['Book title']
    id 'W-00000000'


    access_control
    skip_create
    override_new_record


    after(:build) do |work, evaluator|
      work.apply_depositor_metadata(evaluator.user.user_key)
    end

    factory :book_with_one_file do
      before(:create) do |work, evaluator|
        work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user, title: ['A Contained FileSet'])
      end
    end
  end
end
