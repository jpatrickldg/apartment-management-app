class Concern < ApplicationRecord
  belongs_to :user
  
  enum status: [ :open, :closed ]

  validates :title, presence: true, length: {minimum:10, maximum:30}
  validates :description, presence: true, length: {minimum:10, maximum:100}
end

