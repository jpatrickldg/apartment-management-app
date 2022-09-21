class ProfilesController < ApplicationController

  def show
    @user = current_user
    if @user.tenant?
      if @user.bookings.any?
        @booking = @user.booking
        @room = Room.find(@booking.id)
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Updated Successfully'
    else
      render :edit
    end
  end

  def purge_avatar
    @user = current_user
    if @user.avatar.attached?
      @user.avatar.purge
      redirect_to profile_path, notice: 'Avatar Deleted'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :contact_no, :address, :avatar)
  end

end
