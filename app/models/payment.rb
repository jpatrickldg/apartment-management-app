class Payment < ApplicationRecord
  belongs_to :invoice
  has_one_attached :proof

  after_save :set_invoice_status

  enum payment_mode: [ :cash, :paymongo ]
  enum status: [ :pending, :cancelled, :approved ]

  validates :amount, presence: true

  def set_processed_by(user_email)
    self.processed_by = user_email
    self.save!
  end

  private

  def set_invoice_status
    return unless self.approved?
    invoice = Invoice.find(self.invoice_id)
    invoice.status = 'paid'
    invoice.save!
  end
end
