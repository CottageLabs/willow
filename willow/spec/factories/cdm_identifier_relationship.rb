FactoryGirl.define do

  factory :cdm_identifier_relationship, :class => 'Cdm::IdentifierRelationship' do
    skip_create
    override_new_record
  end

end
