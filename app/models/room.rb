class Room < ApplicationRecord
  belongs_to :branch
  has_many :bookings
  has_many :users, through: :bookings

  before_create :calculate_available_count
  before_save :calculate_available_count

  private

  def calculate_available_count
    self.available_count = self.capacity_count - self.occupants_count
  end

end
