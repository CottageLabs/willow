FactoryGirl.define do

  factory :cdm_date, :class => 'Cdm::Date' do
    skip_create
    override_new_record
  end

end
