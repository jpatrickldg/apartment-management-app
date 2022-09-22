class Announcement < ApplicationRecord
  # after_update :set_published_by_if_published

  enum status: [ :draft, :archived, :published ]

  def set_published_by(user_email)
    if self.published?
      self.published_by = user_email
      self.save!
    end
  end
end
