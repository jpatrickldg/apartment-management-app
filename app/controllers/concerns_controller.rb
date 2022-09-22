class ConcernsController < ApplicationController
  before_action :get_user, only: [:index, :new, :create]
  before_action :set_concern, only: [:show, :edit, :update, :destroy]

  def index
    @concerns = Concern.all
  end

  def show
    @user = User.find(@concern.user_id)
    @room = Room.find(@concern.room_id)
    @branch = Branch.find(@room.branch_id)
  end

  def new
    @concern = @user.concerns.build
  end

  def create
    @concern = @user.concerns.build(concern_params)
    if @concern.save!
      redirect_to authenticated_root_path, notice: 'Concern Ticket Created'
    else
    end
  end

  def edit
  end

  def update
    email = current_user.email
    if @concern.update(concern_params)
      @concern.set_assisted_by(email)
      redirect_to authenticated_root_path, notice: 'Concern Ticket Updated'
    else
      render :edit
    end
  end

  def destroy
  end

  def get_user
    @user = User.find(params[:user_id])
  end

  def set_concern
    @concern = Concern.find(params[:id])
  end

  private

  def concern_params
    params.require(:concern).permit(:user_id, :title, :description, :status, :assisted_by)
  end
  

end
