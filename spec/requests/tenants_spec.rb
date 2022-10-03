require 'rails_helper'

RSpec.describe "Tenants", type: :request do

  let (:admin) { create(:user, role: 'admin') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it 'returns users page' do
      sign_in admin
      get tenants_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get tenants_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:notice]).to match('Access Denied')
    end
  end

  describe "GET /new_tenants" do
    it 'returns new tenants page' do
      sign_in admin
      get new_tenants_tenants_path
      expect(response).to have_http_status(200)
    end

    it 'includes only new tenants' do
      sign_in admin
      user1 = create(:user, occupation: 'reviewee')
      user2 = create(:user, occupation: 'student')
      create(:booking, user_id: user1.id)
      get new_tenants_tenants_path
      expect(response).to have_http_status(200)
      expect(response.body).to_not include(user1.email)
      expect(response.body).to include(user2.email)
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get new_tenants_tenants_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:notice]).to match('Access Denied')
    end

  end

  describe "GET /active" do
    it 'returns new tenants page' do
      sign_in admin
      get active_tenants_path
      expect(response).to have_http_status(200)
    end

    it 'includes only active tenants' do
      sign_in admin
      user1 = create(:user, occupation: 'reviewee')
      create(:booking, user_id: user1.id, status: 'inactive')
      get active_tenants_path
      expect(response).to have_http_status(200)
      expect(response.body).to_not include("Reviewee")
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get active_tenants_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:notice]).to match('Access Denied')
    end
  end

end
