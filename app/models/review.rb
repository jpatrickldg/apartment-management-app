class Review < ApplicationRecord
  belongs_to :user

  validates :maintenance_satisfaction, :responsiveness_effectiveness, :common_area_cleanliness, :lease_renewal_likelihood, :recommend_apartment, :comment, presence: true
  validates :maintenance_satisfaction, :responsiveness_effectiveness, :common_area_cleanliness, :lease_renewal_likelihood, :recommend_apartment, inclusion: { in: 1..5 }

  validates :comment, length: {minimum:5, maximum:100}

  before_save :calculate_overall_score

  private

  def calculate_overall_score
    self.overall_score = (maintenance_satisfaction + responsiveness_effectiveness + common_area_cleanliness + lease_renewal_likelihood + recommend_apartment) / 5.0
  end
end
