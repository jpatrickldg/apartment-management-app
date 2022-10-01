require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'Before registration' do
    it 'will pass with valid attributes' do
      user = create(:user)
      expect(user).to be_valid
    end

    it 'will fail with empty first name' do
      user = build(:user, first_name: nil)
      expect(user).to_not be_valid
    end

    it 'will fail with empty last name' do
      user = build(:user, last_name: nil)
      expect(user).to_not be_valid
    end

    it 'will fail with empty gender' do
      user = build(:user, gender: nil)
      expect(user).to_not be_valid
    end

    it 'will fail with empty birthdate' do
      user = build(:user, birthdate: nil)
      expect(user).to_not be_valid
    end

    it 'will fail with empty contact_no' do
      user = build(:user, contact_no: nil)
      expect(user).to_not be_valid
    end

    it 'will fail if contact_no is not 11 digits ' do
      user = build(:user, contact_no: '1233123')
      expect(user).to_not be_valid
    end


    it 'will fail with empty address' do
      user = build(:user, address: nil)
      expect(user).to_not be_valid
    end

    it 'will fail with empty role' do
      user = build(:user, role: nil)
      expect(user).to_not be_valid
    end
  end

end
