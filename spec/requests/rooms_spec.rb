require 'rails_helper'

RSpec.describe "Rooms", type: :request do

  let (:admin) { create(:user, role: 'admin') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /rooms/available" do
    it 'returns branch rooms page' do
      sign_in admin
      get available_rooms_path
      expect(response).to have_http_status(200)
    end

    it 'only displays available rooms' do
      sign_in admin
      create(:room, room_code: 'RSPEC', occupants_count: 5, capacity_count: 5)
      get available_rooms_path

      expect(response).to have_http_status(200)
      expect(response.body).to_not include('RSPEC')
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get available_rooms_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to match('Access Denied')
    end
  end
end
