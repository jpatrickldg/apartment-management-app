class AddRemarksColumnToConcern < ActiveRecord::Migration[7.0]
  def change
    add_column :concerns, :remarks, :string
  end
end
