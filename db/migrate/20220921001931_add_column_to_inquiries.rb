class AddColumnToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :status, :integer, :default => 0
  end
end
