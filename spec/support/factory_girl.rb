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
end
