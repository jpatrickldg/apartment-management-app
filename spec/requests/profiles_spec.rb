require 'rails_helper'

RSpec.describe "Profiles", type: :request do

  let (:tenant) { create(:user, role: 'tenant') }
  let (:tenant_with_avatar) { create(:user, avatar: Rack::Test::UploadedFile.new('spec/support/test_image.png', 'image/png')) }

  describe "PATCH #update" do
    it "updates user profile" do
      sign_in tenant
      user_params = {
        first_name: 'Edited',
        avatar: Rack::Test::UploadedFile.new('spec/support/test_image.png', 'image/png')
      }
      patch profile_path, params: { user: user_params }
      tenant.reload

      expect(tenant.first_name).to eq 'Edited'
      expect(flash[:notice]).to match('Updated Successfully')
    end
  end

  describe "POST #purge_avatar" do
    it "updates user profile" do
      sign_in tenant_with_avatar

      post purge_avatar_profile_path
      tenant_with_avatar.reload

      expect(flash[:notice]).to match('Avatar Deleted')
    end
  end
end
