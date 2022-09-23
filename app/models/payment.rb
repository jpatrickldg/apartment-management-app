class Payment < ApplicationRecord
  belongs_to :invoice
  has_one_attached :proof

  before_save :set_invoice_status, if: Proc.new { approved? }

  enum payment_mode: [ :cash, :transfer, :gcash ]
  enum status: [ :pending, :cancelled, :approved ]

  def set_processed_by(user_email)
    self.processed_by = user_email
  end

  private

  def set_invoice_status
    invoice = Invoice.find(self.invoice_id)
    invoice.status = 'paid'
    invoice.save!
  end
end
