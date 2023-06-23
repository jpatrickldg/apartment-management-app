class CreateDeposits < ActiveRecord::Migration[7.0]
  def change
    create_table :deposits do |t|
      t.decimal :security
      t.decimal :utility
      t.decimal :key
      t.decimal :bed_sheet
      t.boolean :released, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
