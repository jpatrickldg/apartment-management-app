class UpdateAllTables < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :is_active, :boolean
    remove_column :concerns, :is_active, :boolean
    remove_column :inquiries, :is_signed, :boolean
    remove_column :payments, :payment_from, :date
    remove_column :payments, :payment_to, :date
    remove_reference :payments, :booking, foreign_key: true
    remove_column :rooms, :occupants, :integer
    remove_column :rooms, :capacity, :integer
    remove_column :users, :role, :string
    remove_column :users, :is_active, :boolean

    add_column :announcements, :status, :integer, :default => 0
    add_column :announcements, :published_by, :string
    add_column :bookings, :status, :integer, :default => 0
    add_column :bookings, :processed_by, :string
    add_column :expenses, :processed_by, :string
    add_column :inquiries, :contract_signed, :boolean, :default => false
    add_column :inquiries, :processed_by, :string
    add_reference :payments, :invoice, foreign_key: true
    add_column :payments, :payment_mode, :integer, :default => 0
    add_column :payments, :status, :integer, :default => 0
    add_column :payments, :processed_by, :string
    add_column :rooms, :occupants_count, :integer
    add_column :rooms, :capacity_count, :integer
    add_column :rooms, :available_count, :integer
    add_column :users, :role, :integer, :default => 0
    add_column :users, :emergency_contact_person, :string
    add_column :users, :emergency_contact_no, :string
    add_column :users, :status, :integer, :default => 0

  end
end
