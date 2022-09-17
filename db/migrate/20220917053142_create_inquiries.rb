class CreateInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :inquiries do |t|
      t.string :email, null: false
      t.string :first_name, null: false 
      t.string :last_name, null: false 
      t.string :gender, null: false 
      t.string :contact_no, null: false
      t.string :occupation, null: false
      t.string :location_preference
      t.string :room_type
      t.date :move_in_date
      t.boolean :is_signed, default: false

      t.timestamps
    end
  end
end
