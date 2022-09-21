class AddColumnToConcern < ActiveRecord::Migration[7.0]
  def change
    change_column_null :payments, :invoice_id, false
    add_column :concerns, :status, :integer, :default => 0
    add_column :concerns, :assisted_by, :string
  end
end
