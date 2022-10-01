class Inquiry < ApplicationRecord
  # after_update :set_processed_by_if_on_going

  enum status: [ :open, :on_going, :closed ]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :contact_no, presence: true, length: { is: 11 }
  validates :location_preference, presence: true
  validates :room_type, presence: true
  validates :move_in_date, presence: true

  def set_processed_by_if_on_going(user_email)
    if self.on_going?
      self.processed_by = user_email
      self.save!
    end
  end


end
