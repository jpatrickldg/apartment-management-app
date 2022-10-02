require 'rails_helper'

RSpec.describe "Invoices", type: :request do

  let (:cashier) { create(:user, role: 'cashier') }
  let (:receptionist) { create(:user, role: 'receptionist') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it "returns index page if user is not tenant" do
      sign_in cashier
      get invoices_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get invoices_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:notice]).to match('Access Denied')
    end
  end

  describe "GET /active" do
    it "returns index page if user is not tenant" do
      sign_in cashier
      get active_invoices_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get active_invoices_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:notice]).to match('Access Denied')
    end
  end

  describe "POST #create" do
    it 'creates invoice if user is not tenant or receptionist' do
      sign_in cashier
      booking = create(:booking)
      invoice_params = {
        water_bill: 500,
        electricity_bill: 500,
        room_rate: 5000,
        date_from: Date.today - 1.month,
        date_to: Date.today,
        remarks: "Monthly"
      }

      post booking_invoices_path(booking), params: { invoice: invoice_params }
      expect(flash[:notice]).to match('Invoice Added')
      expect(Invoice.last.processed_by).to eq cashier.email
      expect(Invoice.last.total_amount).to eq 6000
    end
  end

  describe "PATCH #update" do
    it 'updates invoices' do
      sign_in cashier

      invoice = create(:invoice, processed_by: cashier.email)
      invoice_params = {
        water_bill: 50,
        electricity_bill: 50,
        remarks: 'Edited'
      }
      patch invoice_path(invoice), params: { invoice: invoice_params }
      invoice.reload

      expect(invoice.remarks).to eq 'Edited'
      expect(invoice.water_bill).to eq 50
      expect(invoice.electricity_bill).to eq 50
      expect(flash[:notice]).to match('Invoice Updated')
    end
  end

end
