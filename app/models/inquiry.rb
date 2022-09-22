class Inquiry < ApplicationRecord
  # after_update :set_processed_by_if_on_going

  enum status: [ :open, :on_going, :close ]

  def set_processed_by_if_on_going(user_email)
    if self.on_going?
      self.processed_by = user_email
      self.save!
    end
  end


end
