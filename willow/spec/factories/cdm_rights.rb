FactoryGirl.define do

  factory :cdm_rights, :class => 'Cdm::Rights' do
    skip_create
    override_new_record
  end

end
