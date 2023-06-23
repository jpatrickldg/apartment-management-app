class AddDepositFeesToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :security, :decimal, precision: 8, scale: 2, default: 0
    add_column :invoices, :utility, :decimal, precision: 8, scale: 2, default: 0
    add_column :invoices, :key, :decimal, precision: 8, scale: 2, default: 0
    add_column :invoices, :bed_sheet, :decimal, precision: 8, scale: 2, default: 0
  end
end
