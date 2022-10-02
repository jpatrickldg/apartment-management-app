require 'rails_helper'

RSpec.describe "Bookings", type: :request do

  let (:admin) { create(:user, role: 'admin') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it "returns index page if user is tenant" do
      sign_in tenant
      get bookings_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if user is not tenant' do
      sign_in admin
      get bookings_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:notice]).to match('Access Denied')
    end
  end

  describe "POST #create" do
    it 'creates booking' do
      sign_in admin
      tenant1 = create(:user, email: 'rspecbooking@test.com')
      room = create(:room)
      bookings_params = {
        move_in_date: Date.today,
        room_id: room.id
      }

      post tenant_bookings_path(tenant1), params: { booking: bookings_params }
      expect(flash[:notice]).to match('Booking Created')
      expect(Booking.last.user_id).to eq tenant1.id
      expect(Booking.last.processed_by).to eq admin.email
    end
  end

  describe "POST #deactivate" do
    it 'sets booking status to inactive' do
      sign_in admin

      booking = create(:booking)
      post deactivate_booking_path(booking)
      booking.reload

      expect(booking.status).to eq 'inactive'  
      expect(flash[:notice]).to match('Booking Deactivated')
    end

    it "will fail if booking has an active invoice" do
      sign_in admin
      booking = create(:booking)
      invoice = create(:invoice, booking_id: booking.id)

      post deactivate_booking_path(booking)
      booking.reload
      expect(response).to redirect_to(tenants_path)
      expect(flash[:notice]).to match('Failed. Tenant has an active Invoice')
    end
  end
end
