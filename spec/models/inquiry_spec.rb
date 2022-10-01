require 'rails_helper'

RSpec.describe Inquiry, type: :model do

  context 'Before accepting' do
    it 'will pass with valid attributes' do
      inquiry = create(:inquiry)
      expect(inquiry).to be_valid
    end

    it 'will fail with empty first name' do
      inquiry = build(:inquiry, first_name: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will fail with empty last name' do
      inquiry = build(:inquiry, last_name: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will fail with empty gender' do
      inquiry = build(:inquiry, gender: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will fail with empty contact_no' do
      inquiry = build(:inquiry, contact_no: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will fail if contact_no is not 11 digits ' do
      inquiry = build(:inquiry, contact_no: '1233123')
      expect(inquiry).to_not be_valid
    end

    it 'will fail with empty location_preference' do
      inquiry = build(:inquiry, location_preference: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will fail with empty room_type' do
      inquiry = build(:inquiry, room_type: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will fail with empty move_in_date' do
      inquiry = build(:inquiry, move_in_date: nil)
      expect(inquiry).to_not be_valid
    end
  end
  
end
