class Network < ApplicationRecord

  belongs_to :device

  validates :ssid_hash, presence: true
  validates :authorization, inclusion: { in: [true, false] }
  validates :max_distance, numericality: { greater_than: 0 }

end