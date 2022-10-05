require 'rails_helper'

RSpec.describe Announcement, type: :model do
  
  context "before saving" do
    it 'will pass with valid attributes' do
      announcement = create(:announcement)
      expect(announcement).to be_valid
    end

    it 'sets default status' do
      announcement = create(:announcement)
      expect(announcement.status).to_not be == nil
    end

    it 'sets published_by if set_published_by method executes' do
      announcement = build(:announcement, status: 'published')
      announcement.set_published_by("sample@email.com")
      expect(announcement.published_by).to eq "sample@email.com"
    end

    it 'will fail with empty title' do
      announcement = build(:announcement, title: nil)
      expect(announcement).to_not be_valid
    end

    it 'will fail with title shorter than 10 chars' do
      announcement = build(:announcement, title: 'short')
      expect(announcement).to_not be_valid
    end

    it 'will fail with title longer than 30 chars' do
      announcement = build(:announcement, title: 'Lorem, ipsum dolor sit amet consectetur adipisicing elit')
      expect(announcement).to_not be_valid
    end

    it 'will fail with empty description' do
      announcement = build(:announcement, description: nil)
      expect(announcement).to_not be_valid
    end

    it 'will fail with description shorter than 10 chars' do
      announcement = build(:announcement, description: 'short')
      expect(announcement).to_not be_valid
    end
  end
  
end
