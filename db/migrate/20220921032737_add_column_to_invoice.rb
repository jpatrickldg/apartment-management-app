class AddColumnToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :room_rate, :float
  end
end
