class Deposit < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  before_save :set_total_amount
  
  private

  def set_total_amount
    self.total_amount = self.security + self.utility + self.key + self.bed_sheet
  end  
end
