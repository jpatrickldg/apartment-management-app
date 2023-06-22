class AddAddressToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :address, :string, null: false
  end
end
