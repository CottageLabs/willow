FactoryGirl.define do

  factory :rdss_dataset do
    title ["RDSS Dataset"]
    access_control
    skip_create
    override_new_record
  end

end
