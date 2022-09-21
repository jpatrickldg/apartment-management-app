class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :booking, null: false, foreign_key: true
      t.float :water_bill, null: false, default: 0
      t.float :electricity_bill, null: false, default: 0
      t.float :total_amount, null: false, default: 0
      t.date :date_from 
      t.date :date_to 
      t.string :remarks 
      t.integer :status, default: 0
      t.string :processed_by


      t.timestamps
    end
  end
end
