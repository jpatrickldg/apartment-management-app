class Announcement < ApplicationRecord
  after_update :set_published_by_if_published

  enum status: [ :not_set, :published, :archived, :draft ]

  private

  def set_published_by_if_published
    if self.published
      self.published_by = current_user.email
      self.save!
    end
  end
end
