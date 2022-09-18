class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :booking, null: false, foreign_key: true
      t.float :amount
      t.date :payment_from
      t.date :payment_to

      t.timestamps
    end
  end
end
