class RenameTenantNameToTenantFirstNameAndAddTenantLastNameToContracts < ActiveRecord::Migration[7.0]
  def change
    rename_column :contracts, :tenant_name, :tenant_first_name
    add_column :contracts, :tenant_last_name, :string
  end
end
