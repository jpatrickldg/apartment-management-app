require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/reports/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /generate_report" do
    it "returns http success" do
      get "/reports/generate_report"
      expect(response).to have_http_status(:success)
    end
  end

end
