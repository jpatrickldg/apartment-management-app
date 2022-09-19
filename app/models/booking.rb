class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  before_create :set_due_date

  private

  def set_due_date
    self.due_date = self.move_in_date + 1.month
  end

end
