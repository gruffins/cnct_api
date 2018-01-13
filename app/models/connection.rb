class Connection < ApplicationRecord

  enum status: [:pending_sent, :pending_received, :rejected_sent, 
    :rejected_received, :approved]

  belongs_to :user
  belongs_to :other, class_name: 'User'

  validates :other, uniqueness: { scope: :user }

  scope :pending_received, -> { where(status: :pending_received) }

  before_validation :set_default_values

  after_commit :create_reciprical, on: :create
  after_commit :destroy_reciprical, on: :destroy

  def accept!
    update_attributes(status: :approved)
    reciprical.update_attributes(status: :approved)
    true
  end

  def reject!
    update_attributes(status: :rejected_received)
    reciprical.update_attributes(status: :rejected_sent)
    true
  end

  def reciprical
    @reciprical ||= Connection.find_by(user: other, other: user)
  end

  private

  def set_default_values
    self.status ||= :pending_sent
  end

  def create_reciprical
    Connection.create!(user: other, other: user, status: :pending_received) unless reciprical.present?
  end

  def destroy_reciprical
    Connection.find_by(user: other, other: user).try(:destroy)
  end

end