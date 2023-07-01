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
  validates :remarks, presence: true, length: {minimum:3, maximum:30}

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
    self.total_amount = self.water_bill + self.electricity_bill + self.room_rate + self.security + self.penalty + self.utility + self.key + self.bed_sheet
  end  

  def set_booking_due_date
    return unless self.paid?
  
    booking = Booking.find(self.booking_id)
    latest_paid_invoice = booking.invoices.paid.order(created_at: :desc).first
  
    if latest_paid_invoice.present?
      due_date = latest_paid_invoice.date_to + 1.month
      if due_date > booking.move_out_date
        booking.due_date = booking.move_out_date
      else
        booking.due_date = due_date
      end
    else
      booking.due_date = booking.move_in_date + 1.month
    end
  
    booking.save!
  end

end
