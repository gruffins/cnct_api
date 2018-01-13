FactoryBot.define do
  factory :network do
    device
    sequence(:ssid_hash) { |n| Digest::SHA256.hexdigest(n.to_s) }
    authorization false
    max_distance 1 
  end
end