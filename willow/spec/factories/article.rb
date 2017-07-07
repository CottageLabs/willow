FactoryGirl.define do

  factory :article do
    title ["Article"]
    access_control
    skip_create
    override_new_record
  end


  factory :article_seq, class: Article do
    sequence(:id) {|n| "article-#{n}"}
    sequence(:title) {|n| ["Article #{n}"] }
    sequence(:doi) {|n| "123456789/#{n}" }
  end
end