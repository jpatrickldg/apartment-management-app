class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
    if @user.role == 'tenant'
      @booking = @user.booking
      @room = Room.find(@booking.id)
    end
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_profile
    @user = current_user
  end

  def update
    if current_user.role == 'admin'
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to show_user(@user), notice: 'Updated Successfully'
      else
        render :edit
      end
    else 
      @user = current_user
      if @user.update(user_params)
        redirect_to user_profile_path, notice: 'Updated Successfully'
      else
        render :edit_profile
      end
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :contact_no, :address)
  end

end
