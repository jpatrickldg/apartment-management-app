class UsersController < ApplicationController

  def index
    @users = User.all
    @tenants = User.where(role: 'tenant')
  end
  
  def show
    @user = User.find(params[:id])
    @active = @user.bookings.where(status: 'active').last
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :contact_no, :address, :avatar)
  end

end
