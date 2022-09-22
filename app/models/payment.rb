class Payment < ApplicationRecord
  belongs_to :invoice

  before_create :set_initiated_by
  after_update :set_invoice_status_and_processed_by

  enum payment_mode: [ :cash, :bank_transfer ]
  enum status: [ :pending, :cancelled, :approved ]

  private

  def set_initiated_by
    self.initiated_by = current_user.email
  end

  def set_invoice_status_and_processed_by
    if self.approved
      invoice = Invoice.find(self.invoice_id)
      invoice.status = 'paid'
      invoice.save!
    end
    self.processed_by = current_user.email 
    self.save!
  end

end
