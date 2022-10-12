require 'rails_helper'

RSpec.describe "Branches", type: :request do

  let (:admin) { create(:user, role: 'admin') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it 'returns branches page' do
      sign_in admin
      get branches_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get branches_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to match('Access Denied')
    end
  end
end
