class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :maintenance_satisfaction
      t.integer :responsiveness_effectiveness
      t.integer :common_area_cleanliness
      t.integer :lease_renewal_likelihood
      t.integer :recommend_apartment
      t.text :comment

      t.timestamps
    end
  end
end
