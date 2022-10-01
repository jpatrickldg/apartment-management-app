require 'rails_helper'

RSpec.describe User, type: :model do
  # let(:user) { User.new(email: 'trial@test.com', password: '123456') }
  
  context 'Before registration' do

    it 'will not register user with empty first name' do
      user = build(:user, first_name: nil)
      expect(user).to_not be_valid
    end

    it 'will not register user with empty last name' do
      user = build(:user, last_name: nil)
      expect(user).to_not be_valid
    end

    it 'will not register user with empty gender' do
      user = build(:user, gender: nil)
      expect(user).to_not be_valid
    end

    it 'will not register user with empty birthdate' do
      user = build(:user, birthdate: nil)
      expect(user).to_not be_valid
    end

    it 'will not register user with empty contact_no' do
      user = build(:user, contact_no: nil)
      expect(user).to_not be_valid
    end

    it 'will not register user if contact_no is not 11 digits ' do
      user = build(:user, contact_no: '1233123')
      expect(user).to_not be_valid
    end


    it 'will not register user with empty address' do
      user = build(:user, address: nil)
      expect(user).to_not be_valid
    end

    it 'will not register user with empty role' do
      user = build(:user, role: nil)
      expect(user).to_not be_valid
    end

  end

end
