require 'rails_helper'

RSpec.describe Branch, type: :model do

  context "Before saving" do
    it 'will pass with valid attributes' do
      branch = create(:branch)
      expect(branch).to be_valid
    end

    it 'will fail with empty branch_type' do
      branch = build(:branch, branch_type: nil)
      expect(branch).to_not be_valid
    end

    it 'will fail with empty address' do
      branch = build(:branch, address: nil)
      expect(branch).to_not be_valid
    end
  end
  
end
