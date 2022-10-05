class ChangeFloatColumnsToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column_default :invoices, :water_bill, nil
    change_column_default :invoices, :electricity_bill, nil
    change_column_default :invoices, :total_amount, nil

    change_column :payments, :amount, :decimal, precision: 8, scale: 2, default: 0, null: false
    change_column :invoices, :total_amount, :decimal, precision: 8, scale: 2, default: 0
    change_column :invoices, :water_bill, :decimal, precision: 8, scale: 2, default: 0
    change_column :invoices, :electricity_bill, :decimal, precision: 8, scale: 2, default: 0
    change_column :invoices, :room_rate, :decimal, precision: 8, scale: 2, default: 0, null: false
    change_column :expenses, :amount, :decimal, precision: 8, scale: 2, default: 0, null: false
    change_column :rooms, :monthly_rate, :decimal, precision: 8, scale: 2, default: 0, null: false

    add_column :payments, :paymongo_reference, :string
  end
end
