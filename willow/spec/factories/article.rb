FactoryGirl.define do
  factory :article do
    id "article"
    title ["Article"]
    doi "123456789/123456789"
  end

  factory :article_seq, class: Article do
    sequence(:id) {|n| "article-#{n}"}
    sequence(:title) {|n| ["Article #{n}"] }
    sequence(:doi) {|n| "123456789/#{n}" }
  end
end