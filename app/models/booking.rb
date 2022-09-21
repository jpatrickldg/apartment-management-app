class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :invoices
  has_many :payments, through: :invoices

  enum status: [ :active, :inactive ]

  after_create :update_room_occupants

  private

  def update_room_occupants
    room = Room.find(self.room_id)
    room.occupants_count += 1
    room.save!
  end

end
