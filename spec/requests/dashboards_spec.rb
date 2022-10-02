require 'rails_helper'

RSpec.describe "Dashboards", type: :request do

  let (:owner) { create(:user, role: 'owner') }
  let (:admin) { create(:user, role: 'admin') }
  let (:cashier) { create(:user, role: 'cashier') }
  let (:receptionist) { create(:user, role: 'receptionist') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it "renders owner dashboard if user is owner" do
      sign_in owner
      get authenticated_root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Owner')
    end

    it "renders admin dashboard if user is admin" do
      sign_in admin
      get authenticated_root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Admin')
    end

    it "renders cashier dashboard if user is cashier" do
      sign_in cashier
      get authenticated_root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Cashier')
    end

    it "renders receptionist dashboard if user is receptionist" do
      sign_in receptionist
      get authenticated_root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Receptionist')
    end

    it "renders tenant dashboard if user is tenant" do
      sign_in tenant
      get authenticated_root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Tenant')
    end
  end
end
