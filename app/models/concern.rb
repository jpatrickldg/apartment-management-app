class Concern < ApplicationRecord
  belongs_to :user
  
  enum status: [ :open, :closed ]

  validates :title, presence: true
  validates :description, presence: true
end