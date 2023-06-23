class AddTotalAmountAndBookingToDeposits < ActiveRecord::Migration[7.0]
  def change
    add_reference :deposits, :booking, null: false, foreign_key: true
    add_column :deposits, :total_amount, :decimal, precision: 8, scale: 2
  end
end
