class AddColumnToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :remarks, :string
  end
end
