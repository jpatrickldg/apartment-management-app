class Concern < ApplicationRecord
  belongs_to :user
  
  # after_update :set_assisted_by

  enum status: [ :open, :closed ]

  # def set_assisted_by(user_email)
  #   self.assisted_by = user_email
  #   self.save!
  # end

end
