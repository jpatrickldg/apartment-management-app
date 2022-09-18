class Branch < ApplicationRecord
  has_many :rooms, dependent: :destroy
end
