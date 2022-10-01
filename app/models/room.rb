class Room < ApplicationRecord
  belongs_to :branch
  has_many :bookings
  has_many :users, through: :bookings

  before_create :calculate_available_count
  before_save :calculate_available_count

  validates :monthly_rate, presence: true
  validates :room_code, presence: true
  validates :occupants_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  private

  def calculate_available_count
    self.available_count = self.capacity_count - self.occupants_count
  end

end
