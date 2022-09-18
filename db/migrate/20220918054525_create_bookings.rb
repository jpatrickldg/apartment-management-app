class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :move_in_date
      t.date :move_out_date
      t.date :due_date

      t.timestamps
    end
  end
end
