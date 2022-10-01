class Announcement < ApplicationRecord

  enum status: [ :draft, :archived, :published ]

  validates :title, presence: true, length: {minimum:10, maximum:30}
  validates :description, presence: true, length: {minimum:10, maximum:100}

  def set_published_by(user_email)
    if self.published?
      self.published_by = user_email
      self.save!
    end
  end
end
