class Invoice < ApplicationRecord
  belongs_to :booking
  has_one :payment, dependent: :destroy

  before_save :set_total_amount
  after_save :set_booking_due_date
  # after_save :send_message

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

  # def send_message
  #   # Retrieve the amount from the invoice
  #   amount = self.total_amount

  #   # Build the message body with the amount
  #   message_body = "Hello! Your invoice amount is #{amount}."

  #   # Call the send_message action in SmsController and pass the message body
  #   sms_controller = SmsController.new
  #   sms_controller.send_message(message_body)
  # end

  private

  def set_total_amount
    self.total_amount = self.water_bill + self.electricity_bill + self.room_rate
  end  

  def set_booking_due_date
    return unless self.paid?
    booking = Booking.find(self.booking_id)
    booking.due_date += 1.month
    booking.save!
  end

end
