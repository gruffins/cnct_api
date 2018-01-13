FactoryBot.define do
  factory :device do
    user
    uuid SecureRandom.uuid
  end

end