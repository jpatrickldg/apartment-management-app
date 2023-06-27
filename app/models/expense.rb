class Expense < ApplicationRecord
  has_one_attached :proof

  validates :title, presence: true, length: {minimum:5, maximum:30}
  validates :description, presence: true, length: {minimum:10, maximum:100}
  validates :amount, presence: true
  validates :proof, presence: true

  def set_processed_by(user_email)
    self.processed_by = user_email
    self.save!
  end
end
