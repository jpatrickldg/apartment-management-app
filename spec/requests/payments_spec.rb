require 'rails_helper'

RSpec.describe "Payments", type: :request do

  let (:cashier) { create(:user, role: 'cashier') }
  let (:receptionist) { create(:user, role: 'receptionist') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it "returns index page" do
      sign_in cashier
      get invoices_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it 'creates payment' do
      sign_in tenant
      invoice = create(:invoice)
      payment_params = {
        amount: 5000
      }
      post invoice_payment_path(invoice), params: { payment: payment_params }

      expect(flash[:notice]).to match('Payment Submitted')
      expect(Payment.last.initiated_by).to eq tenant.email
    end

    it 'creates payment and executes check_if_by_cashier method if user is a cashier' do
      sign_in cashier
      invoice = create(:invoice)
      payment_params = {
        amount: 5000
      }
      post invoice_payment_path(invoice), params: { payment: payment_params }

      expect(flash[:notice]).to match('Payment Submitted')
      expect(Payment.last.initiated_by).to eq cashier.email
      expect(Payment.last.processed_by).to eq cashier.email
      expect(Payment.last.status).to eq 'approved'
      expect(Payment.last.remarks).to eq 'Cash'
    end
  end

  describe "PATCH #approve_payment" do
    it 'approves payment' do
      sign_in cashier

      invoice = create(:invoice, status: 'unpaid')
      payment = create(:payment, initiated_by: tenant, status: 'pending', invoice_id: invoice.id)
      payment_params = {
        remarks: 'Test Received'
      }
      patch approve_payment_payment_path(payment), params: { payment: payment_params }

      payment.reload
      invoice.reload

      expect(payment.remarks).to eq 'Test Received'
      expect(payment.status).to eq 'approved'
      expect(payment.processed_by).to eq cashier.email
      expect(invoice.status).to eq 'paid'
      expect(flash[:notice]).to match('Payment Approved')
    end
  end
  
end
