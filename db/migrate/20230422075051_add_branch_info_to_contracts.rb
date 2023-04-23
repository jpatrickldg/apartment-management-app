class AddBranchInfoToContracts < ActiveRecord::Migration[7.0]
  def change
    add_column :contracts, :branch_type, :string
    add_column :contracts, :branch_address, :text
  end
end
