require 'rails_helper'

RSpec.describe Concern, type: :model do
  
  context "Before saving" do
    it 'will pass with valid attributes' do
      concern = create(:concern)
      expect(concern).to be_valid
    end

    it 'sets default status' do
      concern = create(:concern)
      expect(concern.status).to_not be == nil
    end

    it 'will fail with empty title' do
      concern = build(:concern, title: nil)
      expect(concern).to_not be_valid
    end

    it 'will fail with title shorter than 5 chars' do
      concern = build(:concern, title: 'test')
      expect(concern).to_not be_valid
    end

    it 'will fail with title longer than 30 chars' do
      concern = build(:concern, title: 'Lorem, ipsum dolor sit amet consectetur adipisicing elit')
      expect(concern).to_not be_valid
    end

    it 'will fail with empty description' do
      concern = build(:concern, description: nil)
      expect(concern).to_not be_valid
    end

    it 'will fail with description shorter than 10 chars' do
      concern = build(:concern, description: 'short')
      expect(concern).to_not be_valid
    end

    it 'will fail with description longer than 100 chars' do
      concern = build(:concern, description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsam, mollitia! Deleniti fugiat expedita quaerat. Modi repellat, omnis laudantium at repellendus quo pariatur molestias')
      expect(concern).to_not be_valid
    end
  end
  
end
