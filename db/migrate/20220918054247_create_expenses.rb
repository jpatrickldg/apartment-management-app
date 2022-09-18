class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end
