require 'rails_helper'

RSpec.describe Room, type: :model do

  context "Before saving" do
    it 'will pass with valid attributes' do
      room = create(:room)
      expect(room).to be_valid
    end

    it 'sets available_count' do
      room = create(:room)
      expect(room.available_count).to_not be == nil
    end

    it 'will fail with empty monthly_rate' do
      room = build(:room, monthly_rate: nil)
      expect(room).to_not be_valid
    end

    it 'will fail with empty room_code' do
      room = build(:room, room_code: nil)
      expect(room).to_not be_valid
    end

    it 'will fail with empty occupants_count' do
      room = build(:room, occupants_count: nil)
      expect(room).to_not be_valid
    end

    it 'will fail with occupants_count that is less than 0' do
      room = build(:room, occupants_count: -1)
      expect(room).to_not be_valid
    end

    it 'will fail with empty capacity_count' do
      room = build(:room, capacity_count: nil)
      expect(room).to_not be_valid
    end

    it 'will fail with capacity_count that is less than 0' do
      room = build(:room, capacity_count: -1)
      expect(room).to_not be_valid
    end
  end

end
