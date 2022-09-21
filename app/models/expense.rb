class Expense < ApplicationRecord
  before_create :set_processed_by

  private

  def set_processed_by
    self.processed_by = current_user.email
  end
end
