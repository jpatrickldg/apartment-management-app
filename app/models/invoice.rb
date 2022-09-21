class Invoice < ApplicationRecord
  belongs_to :booking
  has_one :payment

  before_create :set_processed_by
  after_save :set_booking_due_date

  enum status: [ :sent, :paid, :void ]

  private

  def set_processed_by
    self.processed_by = current_user.email
  end

  def set_booking_due_date
    booking = Booking.find(self.booking_id)
    booking.due_date += 1.month
    booking.save!
  end

end
