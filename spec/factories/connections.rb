FactoryBot.define do
  factory :connection do
    user
    association :other, factory: :user
    status :approved
  end
end