class Branch < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :branch_type, presence: true
  validates :address, presence: true
end
