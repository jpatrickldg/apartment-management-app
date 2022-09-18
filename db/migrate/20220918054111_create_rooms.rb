class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :branch, null: false, foreign_key: true
      t.string :room_type
      t.string :description
      t.float :monthly_rate
      t.integer :occupants
      t.integer :capacity

      t.timestamps
    end
  end
end
