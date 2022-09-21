class Inquiry < ApplicationRecord
  after_update :set_processed_by_if_on_going

  enum status: [ :open, :on_going, :close ]

  private

  def set_processed_by_if_on_going
    if self.on_going
      self.processed_by = current_user.email
      self.save!
    end
  end


end
