require 'rails_helper'

RSpec.describe "Announcements", type: :request do

  let (:tenant) { create(:user, role: 'tenant') }
  let (:admin) { create(:user, role: 'admin') }
  let (:announcement) { create(:announcement) } 

  describe "GET /index" do
    it 'returns announcements page' do
      sign_in tenant
      get announcements_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /new" do
    it 'redirects if user is tenant' do
      sign_in tenant
      get new_announcement_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to match('Access Denied')
    end

    it 'return new announcement page if user is not tenant' do
      sign_in admin
      get new_announcement_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do
    it 'redirects if user is tenant' do
      sign_in tenant
      announcement_params = {
        title: 'Test Announcement',
        description: 'Testing announcements controller with rspec'
      }
      post announcements_path, params: { announcement: announcement_params }

      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to match('Access Denied')
    end

    it 'creates new announcement if user is not tenant' do
      sign_in admin
      announcement_params = {
        title: 'Test Announcement',
        description: 'Testing announcements controller with rspec'
      }
      post announcements_path, params: { announcement: announcement_params }

      expect(flash[:notice]).to match('New Announcement Added')
      expect(Announcement.last.title).to eq 'Test Announcement' 
    end
  end

  describe "PATCH /update" do
    it 'updates the announcement' do
      sign_in admin
      announcement_params = {
        title: 'Test Update Title'
      }
      patch announcement_path(announcement), params: { announcement: announcement_params }
      announcement.reload

      expect(announcement.title).to eq 'Test Update Title'
    end
  end

  describe "POST #archive" do
    it 'sets announcement status to archived' do
      sign_in admin
      post archive_announcement_path(announcement)
      announcement.reload

      expect(announcement.status).to eq 'archived'  
    end
  end
  
  describe "POST #republish" do
    before do
      sign_in admin
    end

    it 'sets announcement status to published' do
      post republish_announcement_path(announcement)
      announcement.reload

      expect(announcement.status).to eq 'published'  
    end

    it 'sets published_by if status is set to published' do
      post republish_announcement_path(announcement)
      announcement.reload

      expect(announcement.published_by).to eq admin.email  
    end
  end
  
end
