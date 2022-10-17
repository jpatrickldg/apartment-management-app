require 'rails_helper'

RSpec.describe "Inquiries", type: :request do

  let (:admin) { create(:user, role: 'admin') }
  let (:receptionist) { create(:user, role: 'receptionist') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it "returns the index page" do
      sign_in admin
      get inquiries_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get inquiries_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to match('Access Denied')
    end
  end

  describe "GET /close" do
    it "returns the close page if processed_by is equal to current user email" do
      sign_in receptionist
      inquiry = create(:inquiry)
      
      post assists_inquiry_path(inquiry)
      inquiry.reload
      get close_inquiry_path(inquiry)
      expect(response).to have_http_status(200)
    end

    it 'redirects if user email is not equal to processed_by' do
      sign_in receptionist
      inquiry = create(:inquiry, processed_by: 'test@email.com')
      
      get close_inquiry_path(inquiry)
      expect(response).to redirect_to(inquiries_path)
      expect(flash[:alert]).to match('Access Denied')
    end
  end

  describe "POST #create" do
    it 'creates inquiry' do
      inquiry_params = {
        email: "inquiry@example.com",
        first_name: "Inquiry",
        last_name: "Test",
        gender: "female",
        contact_no: "09123232231",
        occupation: "student",
        location_preference: "test location",
        room_type: "test room",
        move_in_date: Date.today
      }

      post inquiries_path, params: { inquiry: inquiry_params }
      expect(response).to redirect_to(inquiry_submitted_path)
    end
  end

  describe "PATCH #update" do
    it "closes inquiry if on_going and was processed by current user" do
      sign_in receptionist
      inquiry = create(:inquiry, processed_by: receptionist.email, status: 'on_going')
      inquiry_params = {
        status: 'closed'
      }
      patch inquiry_path(inquiry), params: { inquiry: inquiry_params }
      inquiry.reload

      expect(inquiry.status).to eq 'closed'
      expect(flash[:notice]).to match('Inquiry Closed')
    end
  end

  describe "POST #assists" do
    it 'sets inquiry status to on_going' do
      sign_in receptionist
      inquiry = create(:inquiry)

      post assists_inquiry_path(inquiry)
      inquiry.reload

      expect(inquiry.status).to eq 'on_going'  
      expect(inquiry.processed_by).to eq receptionist.email 
      expect(response).to redirect_to(inquiries_path)
    end
  end
  
end
