class RemoveUserReferenceFromExpense < ActiveRecord::Migration[7.0]
  def change
    remove_column :expenses, :user_id
  end
end
