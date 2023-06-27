require 'rails_helper'

RSpec.describe Expense, type: :model do
  
  context "Before saving" do
    it 'will pass with valid attributes' do
      expense = create(:expense)
      expect(expense).to be_valid
    end

    it 'will set processed_by if set_processed_by method is called' do
      expense = build(:expense)
      expense.set_processed_by("test@email.com")
      expect(expense.processed_by).to eq "test@email.com"  
    end

    it 'will fail with empty title' do
      expense = build(:expense, title: nil)
      expect(expense).to_not be_valid
    end

    it 'will fail with title shorter than 5 chars' do
      expense = build(:expense, title: 'test')
      expect(expense).to_not be_valid
    end

    it 'will fail with title longer than 30 chars' do
      expense = build(:expense, title: 'Lorem, ipsum dolor sit amet consectetur adipisicing elit')
      expect(expense).to_not be_valid
    end

    it 'will fail with empty description' do
      expense = build(:expense, description: nil)
      expect(expense).to_not be_valid
    end

    it 'will fail with description shorter than 10 chars' do
      expense = build(:expense, description: 'short')
      expect(expense).to_not be_valid
    end

    it 'will fail with description longer than 100 chars' do
      expense = build(:expense, description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsam, mollitia! Deleniti fugiat expedita quaerat. Modi repellat, omnis laudantium at repellendus quo pariatur molestias')
      expect(expense).to_not be_valid
    end

    it 'will fail with empty amount' do
      expense = build(:expense, amount: nil)
      expect(expense).to_not be_valid
    end

    it 'will fail with empty proof' do
      expense = build(:expense, proof: nil)
      expect(expense).to_not be_valid
    end
  end

  context "after submitting expense" do
    it 'will set processed_by if set_processed_by method executes' do
      expense = build(:expense, processed_by: nil)
      expense.set_processed_by("sample@email.com")
      expect(expense.processed_by).to eq "sample@email.com"
      expect(expense).to be_valid
    end
  end
  
end
