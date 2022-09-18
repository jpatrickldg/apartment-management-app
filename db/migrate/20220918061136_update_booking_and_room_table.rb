class UpdateBookingAndRoomTable < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :is_active, :boolean, :default => true
    remove_column :rooms, :room_type, :string 
    remove_column :rooms, :description, :string
  end
end
