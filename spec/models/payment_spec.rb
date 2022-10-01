require 'rails_helper'

RSpec.describe Payment, type: :model do
  
  context "Before saving" do
    it 'will pass with valid attributes' do
      payment = create(:payment)
      expect(payment).to be_valid
    end

    it 'sets default status' do
      payment = create(:payment)
      expect(payment.status).to_not be == nil
    end

    it 'sets processed_by if set_processed_by method executes' do
      payment = build(:payment)
      payment.set_processed_by("sample@email.com")
      expect(payment.processed_by).to eq "sample@email.com"
    end

    it 'will fail with empty amount' do
      payment = build(:payment, amount: nil)
      expect(payment).to_not be_valid 
    end
  end

  context "after payment is approved" do
    it 'will update invoice status to paid' do
      invoice = create(:invoice)
      payment = create(:payment, invoice_id: invoice.id)
      before_save = invoice.status
      payment.approved!
      invoice.reload
      expect(invoice.status).to_not eq before_save  
    end
  end
  
end
