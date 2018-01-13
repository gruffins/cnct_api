FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}@example.com" }
    sequence(:username) { |n| "user#{n}" }
    password "password"
  end
end