class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :lock, :unlock]

  def index
    @q = User.where.not(role: 'owner').ransack(params[:q])
    @users = @q.result(distinct: true)
    @active_users = User.all.where(status: 'active')
    @inactive_users = User.all.where(status: 'inactive')
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User Created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Role Updated'
    else
      render :edit
    end
  end

  def destroy
  end

  def lock
    @user.inactive!
    redirect_to user_path(@user), notice: 'User Account Locked'
  end

  def unlock
    @user.active!
    redirect_to user_path(@user), notice: 'User Account Unlocked'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthdate, :gender, :contact_no, :address, :email, :password, :password_confirmation, :role )
  end
  

end
