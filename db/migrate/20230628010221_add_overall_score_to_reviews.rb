class AddOverallScoreToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :overall_score, :float, default: 0.0
  end
end
