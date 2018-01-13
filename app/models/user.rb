class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :devices, dependent: :destroy
  has_many :networks, through: :devices, dependent: :destroy
  has_many :connections, dependent: :destroy

  validates :username, length: { minimum: 3 }, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/i }

  def update_user(params)
    if params[:password].present?
      update_with_password(params)
    else
      update_attributes(params)
    end
  end
end
