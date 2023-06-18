class AddBirthdateToInquiries < ActiveRecord::Migration[7.0]
  def change
    add_column :inquiries, :birthdate, :date, null: false
  end
end
