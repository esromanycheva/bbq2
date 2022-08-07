FactoryBot.define do
  factory :event do
    association :user
    title { "Party" }
    address { "Paris" }
    datetime { Time.now }
  end
end