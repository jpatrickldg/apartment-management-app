class Expense < ApplicationRecord
  has_one_attached :proof

  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :processed_by, presence: true
  validates :proof, presence: true

  def set_processed_by(user_email)
    self.processed_by = user_email
    self.save!
  end
end
