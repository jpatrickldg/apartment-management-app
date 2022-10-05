class Invoice < ApplicationRecord
  belongs_to :booking
  has_one :payment

  before_create :set_total_amount
  after_save :set_booking_due_date, if: Proc.new { paid? }

  enum status: [ :unpaid, :paid ]

  validates :water_bill, presence: true
  validates :electricity_bill, presence: true
  validates :room_rate, presence: true
  validates :date_from, presence: true
  validates :date_to, presence: true
  validates :remarks, presence: true, length: {minimum:5, maximum:30}

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
