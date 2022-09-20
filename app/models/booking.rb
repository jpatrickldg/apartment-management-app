class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  before_create :set_due_date
  after_create :update_room_occupants

  private

  def set_due_date
    self.due_date = self.move_in_date + 1.month
  end

  def update_room_occupants
    room = Room.find(self.room_id)
    room.occupants += 1
    room.save!
  end

end
