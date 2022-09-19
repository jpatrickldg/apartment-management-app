class TenantsController < ApplicationController

  def dashboard
    @announcement = Announcement.last
  end

end
