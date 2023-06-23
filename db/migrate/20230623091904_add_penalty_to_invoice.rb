class AddPenaltyToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :penalty, :decimal, precision: 8, scale: 2, default: 0
  end
end
