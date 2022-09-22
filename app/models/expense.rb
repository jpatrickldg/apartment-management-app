class Expense < ApplicationRecord
  has_one_attached :proof

  def set_processed_by(user_email)
    self.processed_by = user_email
    self.save!
  end
end
