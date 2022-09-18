class CreateConcerns < ActiveRecord::Migration[7.0]
  def change
    create_table :concerns do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.boolean :is_active

      t.timestamps
    end
  end
end
