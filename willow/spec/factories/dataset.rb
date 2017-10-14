FactoryGirl.define do

  factory :dataset do
    title ["Dataset"]
    access_control
    skip_create
    override_new_record
  end

end
