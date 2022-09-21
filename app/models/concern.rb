class Concern < ApplicationRecord
  belongs_to :user
  
  after_update :set_assisted_by

  enum status: [ :open, :close, :resolved ]

  private

  def set_assisted_by
    self.assisted_by = current_user.email 
    self.save!
  end

end
