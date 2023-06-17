class Inquiry < ApplicationRecord
  # after_update :set_processed_by_if_on_going

  enum status: [ :open, :on_going, :closed ]

  before_save :format_contact_no

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :contact_no, presence: true, length: { is: 11 }
  validates :occupation, presence: true
  validates :location_preference, presence: true
  validates :room_type, presence: true
  validates :move_in_date, presence: true

  def set_processed_by_if_on_going(user_email)
    if self.on_going?
      self.processed_by = user_email
      self.save!
    end
  end

  def format_contact_no
    return if contact_no.blank?

    self.contact_no = "+63" + contact_no[1..-1]
  end


end
