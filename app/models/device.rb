class Device < ApplicationRecord

  belongs_to :user

  has_many :networks

  validates :uuid, presence: true, uniqueness: true

  def self.find_or_create_device!(params, user)
    device = Device.find_or_create_by(params)
    device.user = user
    device.save
    device
  end

end