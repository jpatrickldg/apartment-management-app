require 'rails_helper'

RSpec.describe "Expenses", type: :request do

  let (:admin) { create(:user, role: 'admin') }
  let (:tenant) { create(:user, role: 'tenant') }

  describe "GET /index" do
    it 'returns expenses page' do
      sign_in admin
      get expenses_path
      expect(response).to have_http_status(200)
    end

    it 'redirects if user is tenant' do
      sign_in tenant
      get expenses_path
      expect(response).to redirect_to(authenticated_root_path)
      expect(flash[:alert]).to match('Access Denied')
    end
  end

  describe "POST #create" do
    it 'creates expense' do
      sign_in admin
      expense_params = {
        title: "Test Expense",
        description: "Testing expense with rspec",
        amount: 500,
        processed_by: "test@example.com",
        proof: Rack::Test::UploadedFile.new('spec/support/test_image.png', 'image/png')
      }

      post expenses_path, params: { expense: expense_params }
      expect(flash[:notice]).to match('New Expense Added')
      expect(Expense.last.processed_by).to eq admin.email
      expect(Expense.last.title).to eq "Test Expense"
    end
  end
end
