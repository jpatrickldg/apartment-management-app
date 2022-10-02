require 'rails_helper'

RSpec.describe "Users", type: :request do

  let (:admin) { create(:user, role: 'admin') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it 'returns users page' do
      sign_in admin
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it 'creates user' do
      sign_in admin
      user_params = {
        email: 'trial@example.com',
        password: "SecretPassword123",
        password_confirmation: "SecretPassword123",
        first_name: "tenant",
        last_name: "tenant",
        gender: "male",
        birthdate: Date.today,
        contact_no: "09123232231",
        address: 'Test Address',
        confirmed_at: Time.now
      }

      post users_path, params: { user: user_params }
      expect(flash[:notice]).to match('User Created')
      expect(User.last.email).to eq 'trial@example.com'
    end
  end

  describe "PATCH #update" do
    it 'updates user role' do
      sign_in admin
      user_params = {
        role: 'cashier'
      }
      patch user_path(tenant), params: { user: user_params }
      tenant.reload

      expect(tenant.role).to eq 'cashier'
      expect(flash[:notice]).to match('Role Updated')
    end
  end

  describe "PATCH #update_password" do
    it 'updates user password' do
      sign_in tenant
      user_params = {
        password: 'changepassword123',
        password_confirmation: 'changepassword123'
      }
      patch update_password_user_path, params: { user: user_params }
      tenant.reload

      expect(tenant.password).to eq 'changepassword123'
      expect(flash[:notice]).to match('Password Changed')
    end
  end

  describe "POST #lock" do
    it 'sets user status to inactive' do
      sign_in admin
      post lock_user_path(tenant)
      tenant.reload

      expect(tenant.status).to eq 'inactive'  
      expect(flash[:notice]).to match('User Account Locked')
    end
  end

  describe "POST #unlock" do
    it 'sets user status to inactive' do
      sign_in admin
      post unlock_user_path(tenant)
      tenant.reload

      expect(tenant.status).to eq 'active'  
      expect(flash[:notice]).to match('User Account Unlocked')
    end
  end
  
end
