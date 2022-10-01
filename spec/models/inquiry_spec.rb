require 'rails_helper'

RSpec.describe Inquiry, type: :model do

  context 'Before accepting inquiry' do

    it 'will not accept inquiry with empty first name' do
      inquiry = build(:inquiry, first_name: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will not accept inquiry with empty last name' do
      inquiry = build(:inquiry, last_name: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will not accept inquiry with empty gender' do
      inquiry = build(:inquiry, gender: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will not accept inquiry with empty contact_no' do
      inquiry = build(:inquiry, contact_no: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will not accept inquiry if contact_no is not 11 digits ' do
      inquiry = build(:inquiry, contact_no: '1233123')
      expect(inquiry).to_not be_valid
    end

    it 'will not accept inquiry with empty location_preference' do
      inquiry = build(:inquiry, location_preference: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will not accept inquiry with empty room_type' do
      inquiry = build(:inquiry, room_type: nil)
      expect(inquiry).to_not be_valid
    end

    it 'will not accept inquiry with empty move_in_date' do
      inquiry = build(:inquiry, move_in_date: nil)
      expect(inquiry).to_not be_valid
    end

  end
end
