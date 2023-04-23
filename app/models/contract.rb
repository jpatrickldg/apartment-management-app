class Contract < ApplicationRecord
  belongs_to :booking

  before_save :set_status_from_booking
  before_save :set_valid_from_from_booking
  before_save :set_valid_to_from_booking

  enum status: [ :active, :inactive ]

  private
  
  def set_status_from_booking
    if booking && booking.saved_change_to_status?
      self.status = booking.status
    end
  end

  def set_valid_from_from_booking
    if booking && booking.saved_change_to_move_in_date?
      self.valid_from = booking.move_in_date
    end
  end
  
  def set_valid_to_from_booking
    if booking && booking.saved_change_to_move_out_date?
      self.valid_to = booking.move_out_date
    end
  end

end
