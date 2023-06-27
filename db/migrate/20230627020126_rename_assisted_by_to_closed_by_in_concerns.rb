class RenameAssistedByToClosedByInConcerns < ActiveRecord::Migration[7.0]
  def change
    rename_column :concerns, :assisted_by, :closed_by
  end
end
