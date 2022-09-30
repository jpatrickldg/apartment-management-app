class ProfilesController < ApplicationController
  before_action :set_user

  def show
    if @user.tenant?
      @active_booking = @user.bookings.includes(room: [:branch]).find_by(status: 'active')
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Updated Successfully'
    else
      render :edit
    end
  end

  def purge_avatar
    if @user.avatar.attached?
      @user.avatar.purge
      redirect_to profile_path, notice: 'Avatar Deleted'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :contact_no, :address, :emergency_contact_person, :emergency_contact_no, :avatar)
  end

end
