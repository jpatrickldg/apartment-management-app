class Comment < ApplicationRecord
  belongs_to :concern
  belongs_to :user
end
