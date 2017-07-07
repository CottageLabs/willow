FactoryGirl.define do

  factory :access_control, class: Hydra::AccessControl do
    skip_create
  end

  factory :list_source, class: ActiveFedora::Aggregation::ListSource do
    skip_create
  end

  factory :relation, class: ActiveTriples::Relation do
    skip_create
  end

end
