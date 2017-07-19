FactoryGirl.define do
  factory :file_set, class: FileSet do
    transient do
      user { FactoryGirl.create(:user) }
    end
    id 'FS-0000000'

    skip_create
    override_new_record
  end
end
