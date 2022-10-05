require 'rails_helper'

RSpec.describe Booking, type: :model do
  
  context "Before saving" do
    it 'will pass with valid attributes' do
      booking = create(:booking)
      expect(booking).to be_valid
    end

    # it 'will fail if active booking already exists' do
    #   booking = create(:booking)
    #   booking2 = build(:booking)
    #   expect(booking2).to_not be_valid
    # end

    it 'sets default status' do
      booking = create(:booking)
      expect(booking.status).to_not be == nil
    end

    it 'sets due_date' do
      booking = create(:booking)
      expect(booking.due_date).to_not be == nil
    end

    it 'sets processed_by if set_processed_by method executes' do
      booking = build(:booking)
      booking.set_processed_by("sample@email.com")
      expect(booking.processed_by).to eq "sample@email.com"
    end

    it 'will fail with empty move_in_date' do
      booking = build(:booking, move_in_date: nil)
      expect(booking).to_not be_valid
    end
  end

  context "After booking is deactivated" do
    it 'will update room occupants count' do
      room = create(:room, occupants_count: 10)
      booking = create(:booking, room_id: room.id)
      room.reload
      before_save = room.occupants_count #11
      booking.inactive! #10
      room.reload
      expect(room.occupants_count).to_not eq before_save
    end

    it "will deactivate account of booking's owner" do
      user = create(:user)
      booking = create(:booking, user_id: user.id)
      booking.inactive!
      user.reload
      expect(user.status).to eq "inactive"
    end
  end

  context "After saving" do
    it 'will update room occupants count' do
      room = create(:room)
      before_save = room.occupants_count
      booking = create(:booking, room_id: room.id)
      room.reload
      expect(room.occupants_count).to eq 6
    end
  end
  
  context "before deactivating" do
    it 'will fail if any invoice is unpaid' do
      booking = create(:booking)
      invoice = create(:invoice, booking_id: booking.id)
      booking.status = 'inactive'
      expect(booking).to_not be_valid
    end
  end
  
end
