require 'rails_helper'

RSpec.describe Invoice, type: :model do
  
  context "Before saving" do
    it 'will pass with valid attributes' do
      invoice = create(:invoice)
      expect(invoice).to be_valid
    end

    it 'sets total_amount' do
      invoice = create(:invoice)
      expect(invoice.total_amount).to eq invoice.water_bill + invoice.electricity_bill + invoice.room_rate
    end

    it 'sets default status' do
      invoice = create(:invoice)
      expect(invoice.status).to_not be == nil
    end

    it 'sets processed_by if set_processed_by method executes' do
      invoice = build(:invoice)
      invoice.set_processed_by("sample@email.com")
      expect(invoice.processed_by).to eq "sample@email.com"
    end

    it 'will fail with empty water_bill' do
      invoice = build(:invoice, water_bill: nil)
      expect(invoice).to_not be_valid
    end

    it 'will fail with empty electricity_bill' do
      invoice = build(:invoice, electricity_bill: nil)
      expect(invoice).to_not be_valid
    end

    it 'will fail with empty room_rate' do
      invoice = build(:invoice, room_rate: nil)
      expect(invoice).to_not be_valid
    end

    it 'will fail with empty date_from' do
      invoice = build(:invoice, date_from: nil)
      expect(invoice).to_not be_valid
    end

    it 'will fail with empty date_to' do
      invoice = build(:invoice, date_to: nil)
      expect(invoice).to_not be_valid
    end

    it 'will fail with empty remarks' do
      invoice = build(:invoice, remarks: nil)
      expect(invoice).to_not be_valid
    end

    it 'will fail with remarks shorter than 5 chars' do
      invoice = build(:invoice, remarks: 'shrt')
      expect(invoice).to_not be_valid
    end

    it 'will fail with remarks longer than 30 chars' do
      invoice = build(:invoice, remarks: 'Lorem, ipsum dolor sit amet consectetur adipisicing elit')
      expect(invoice).to_not be_valid
    end
  end

  context "if status is paid after save" do
    it 'will update booking due date' do
      invoice = create(:invoice)
      booking = Booking.find(invoice.booking_id)
      before_update = booking.due_date
      invoice.paid!
      booking.reload
      expect(booking.due_date).to_not eq before_update
    end
  end
  
end
