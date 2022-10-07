class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :lock, :unlock]
  before_action :check_restriction, except: [:change_password, :update_password]

  def index
    if current_user.owner?
      @q = User.ransack(params[:q])
    elsif current_user.admin?
      @q = User.where.not(role: 'owner').ransack(params[:q])
    end
    @users = @q.result(distinct: true)
    @active_users = User.all.where(status: 'active')
    @inactive_users = User.all.where(status: 'inactive')
  end

  def active
    @q = User.where(status: 'active').ransack(params[:q])
    @users = @q.result(distinct: true)
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

  def change_password
    @user = current_user 
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to profile_path, notice: 'Password Changed'
    else
      render :change_password
    end
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

  def check_restriction
    if current_user.tenant? || current_user.receptionist? || current_user.cashier?
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthdate, :gender, :contact_no, :address, :email, :password, :password_confirmation, :role )
  end
  

end
