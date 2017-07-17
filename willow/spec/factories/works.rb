FactoryGirl.define do
  factory :work, aliases: [:private_work], class: Work do

    transient do
     user { FactoryGirl.create(:user) }
    end

    title ['Work title']
    id '00000000-0000-0000-0000-000000000000'


    # factory :access_control, class: Hydra::AccessControl do
    #   skip_create
    # end


    access_control

    #visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE

    skip_create
    override_new_record


    after(:build) do |work, evaluator|
      work.apply_depositor_metadata(evaluator.user.user_key)
    end

    factory :public_work, traits: [:public]

    # factory :authenticated_work, traits: [:authenticated]

    # trait :public do
    #   visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
    # end
    #
    # trait :authenticated do
    #   visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_AUTHENTICATED
    # end
    #
    factory :work_with_one_file do
      before(:create) do |work, evaluator|
        work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user, title: ['A Contained FileSet'])
      end
    end
    #
    # factory :work_with_one_child do
    #   before(:create) do |work, evaluator|
    #     work.ordered_members << FactoryGirl.create(:work, user: evaluator.user, title: ['A Contained Work'])
    #   end
    # end
    #
    # factory :work_with_two_children do
    #   before(:create) do |work, evaluator|
    #     work.ordered_members << FactoryGirl.create(:work, user: evaluator.user, title: ['A Contained Work'], id: "BlahBlah1")
    #     work.ordered_members << FactoryGirl.create(:work, user: evaluator.user, title: ['Another Contained Work'], id: "BlahBlah2")
    #   end
    # end
    #
    # factory :work_with_representative_file do
    #   before(:create) do |work, evaluator|
    #     work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user, title: ['A Contained FileSet'])
    #     work.representative_id = work.members[0].id
    #   end
    # end
    #
    # factory :work_with_file_and_work do
    #   before(:create) do |work, evaluator|
    #     work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user)
    #     work.ordered_members << FactoryGirl.create(:work, user: evaluator.user)
    #   end
    # end
    #
    # factory :work_with_files do
    #   before(:create) { |work, evaluator| 2.times { work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user) } }
    # end
    #
    # factory :work_with_ordered_files do
    #   before(:create) do |work, evaluator|
    #     work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user)
    #     work.ordered_member_proxies.insert_target_at(0, FactoryGirl.create(:file_set, user: evaluator.user))
    #   end
    # end
    #
    # factory :with_embargo_date do
    #   transient do
    #     embargo_date { Date.tomorrow.to_s }
    #     current_state { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE }
    #     future_state { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
    #   end
    #   factory :embargoed_work do
    #     after(:build) { |work, evaluator| work.apply_embargo(evaluator.embargo_date, evaluator.current_state, evaluator.future_state) }
    #   end
    #   factory :embargoed_work_with_files do
    #     after(:build) { |work, evaluator| work.apply_embargo(evaluator.embargo_date, evaluator.current_state, evaluator.future_state) }
    #     after(:create) { |work, evaluator| 2.times { work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user) } }
    #   end
    # end
    #
    # factory :with_lease_date do
    #   transient do
    #     lease_date { Date.tomorrow.to_s }
    #     current_state { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC }
    #     future_state { Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE }
    #   end
    #   factory :leased_work do
    #     after(:build) { |work, evaluator| work.apply_lease(evaluator.lease_date, evaluator.current_state, evaluator.future_state) }
    #   end
    #   factory :leased_work_with_files do
    #     after(:build) { |work, evaluator| work.apply_lease(evaluator.lease_date, evaluator.current_state, evaluator.future_state) }
    #     after(:create) { |work, evaluator| 2.times { work.ordered_members << FactoryGirl.create(:file_set, user: evaluator.user) } }
    #   end
    # end
    #
    # skip_create
    # override_new_record
  end

  # Doesn't set up any edit_users
  factory :work_without_access, class: Work do
    title ['Test title']
    depositor { FactoryGirl.create(:user).user_key }
  end
end
