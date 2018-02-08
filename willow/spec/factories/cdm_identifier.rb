FactoryGirl.define do

  factory :cdm_identifier, :class => 'Cdm::Identifier' do
    skip_create
    override_new_record
  end

end
