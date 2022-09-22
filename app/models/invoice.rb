class Invoice < ApplicationRecord
  belongs_to :booking
  has_one :payment

  before_create :set_total_amount
  after_save :set_booking_due_date

  enum status: [ :sent, :paid, :void ]

  def set_processed_by(user_email)
    self.processed_by = user_email
    self.save!
  end

  private

  def set_total_amount
    self.total_amount = self.water_bill + self.electricity_bill + self.room_rate
  end  

  def set_booking_due_date
    booking = Booking.find(self.booking_id)
    booking.due_date += 1.month
    booking.save!
  end

end
