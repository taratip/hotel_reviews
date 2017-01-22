require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :hotel do
    sequence(:name) { |n| "hotel park #{n}"}
    sequence(:address) { |n| "#{1000 + n} Boston, USA" }

    user
  end

  factory :review do
    rating 4
    sequence(:body) { |n| "great location nears transporation #{100 + n}!"}

    user
    hotel
  end

  factory :vote do
    score 1

    user
    review
  end
end
