class CreateContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :contracts do |t|
      t.string :tenant_name
      t.text :tenant_address
      t.string :room_code
      t.date :valid_from
      t.date :valid_to
      t.decimal :monthly_rate
      t.date :date_signed
      t.integer :status, default: 0
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
