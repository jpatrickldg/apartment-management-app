class TenantsController < ApplicationController

  def dashboard
    @announcement = Announcement.last
  end

  def profile
    @user = current_user
    @booking = @user.booking
    @room = Room.find(@booking.id)
  end

end
