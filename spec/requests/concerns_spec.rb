require 'rails_helper'

RSpec.describe "Concerns", type: :request do
  
  let (:admin) { create(:user, role: 'admin') }
  let (:tenant1) { create(:user, role: 'tenant') }
  let (:tenant2) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it 'returns expenses page' do
      sign_in admin
      get concerns_path
      expect(response).to have_http_status(200)
    end

    it 'returns expenses specific to user if tenant' do
      sign_in tenant1
      concern1 = create(:concern, user_id: tenant1.id, title: "Current User Concern")
      concern1 = create(:concern, user_id: tenant2.id, title: "Other User Concern")

      get concerns_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Current User Concern")  
      expect(response.body).to_not include("Other User Concern")  
    end
  end

  describe "GET /new" do
    it 'returns new expenses page' do
      sign_in tenant1
      get new_concern_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if user is not tenant' do
      sign_in admin
      get new_concern_path
      expect(response).to redirect_to(concerns_path)
      expect(flash[:alert]).to match('Access Denied')
    end
  end

  describe "POST #create" do
    it 'creates concern' do
      sign_in tenant1
      concerns_params = {
        title: "Test Concern",
        description: "Testing concern with rspec"
      }

      post concerns_path, params: { concern: concerns_params }
      expect(flash[:notice]).to match('Ticket Created')
      expect(Concern.last.title).to eq "Test Concern"
    end
  end

  describe "PATCH #update" do
    it "closes concern ticket" do
      sign_in admin
      concern = create(:concern)
      concern_params = {
        status: 'closed'
      }
      patch concern_path(concern), params: { concern: concern_params }
      concern.reload

      expect(concern.status).to eq 'closed'
      expect(flash[:notice]).to match('Ticket Closed')
    end
  end

  describe "POST #reopen" do
    it 'sets concern status to open' do
      sign_in tenant1
      concern = create(:concern, user_id: tenant1.id)

      post reopen_concern_path(concern)
      concern.reload

      expect(flash[:notice]).to match('Ticket Re-Opened')
      expect(concern.status).to eq 'open'  
    end

    it 'redirects if user is not the creator' do
      sign_in tenant1
      concern = create(:concern, user_id: tenant2.id)

      post reopen_concern_path(concern)
      concern.reload

      expect(flash[:alert]).to match('Access Denied')
      expect(response).to redirect_to(concerns_path) 
    end
  end
end
