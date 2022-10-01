require 'rails_helper'

RSpec.describe Expense, type: :model do
  
  context "before saving expense" do
    it 'is valid with valid attributes' do
      expense = create(:expense)
      expect(expense).to be_valid
    end

    it 'will not accept expense with empty title' do
      expense = build(:expense, title: nil)
      expect(expense).to_not be_valid
    end

    it 'will not accept expense with empty description' do
      expense = build(:expense, description: nil)
      expect(expense).to_not be_valid
    end

    it 'will not accept expense with empty amount' do
      expense = build(:expense, amount: nil)
      expect(expense).to_not be_valid
    end

    it 'will not accept expense with empty processed_by' do
      expense = build(:expense, processed_by: nil)
      expect(expense).to_not be_valid
    end

    it 'will not accept expense with empty proof' do
      expense = build(:expense, proof: nil)
      expect(expense).to_not be_valid
    end
  end

  context "after submitting expense" do
    it 'is will run set_processed_by method to set processed_by' do
      expense = build(:expense, processed_by: nil)
      expense.set_processed_by("sample@email.com")
      expect(expense.processed_by).to eq "sample@email.com"
      expect(expense).to be_valid
    end
  end
  

end
