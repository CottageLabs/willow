FactoryGirl.define do

  factory :rdss_cdm do
    title ["RDSS CDM"]
    access_control
    skip_create
    override_new_record
  end

end
