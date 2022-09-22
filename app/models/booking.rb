class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :invoices, dependent: :destroy
  has_many :payments, through: :invoices

  enum status: [ :active, :inactive ]

  # before_save :set_processed_by
  before_create :set_due_date
  after_destroy :set_room_occupants_once_inactive_or_destroyed

  def set_processed_by(user_email)
    self.processed_by = user_email
    self.save!
  end

  def set_room_occupants_once_inactive_or_destroyed
    room = Room.find(self.room_id)
    if room.occupants_count > 0
      room.occupants_count -= 1
      room.save!
    end
  end
  
  def update_room_occupants
    room = Room.find(self.room_id)
    room.occupants_count += 1
    room.save!
  end

  private

  def set_due_date
    self.due_date = self.move_in_date + 1.month
  end
end
