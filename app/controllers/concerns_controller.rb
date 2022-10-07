class ConcernsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_tenant, only: [:index, :new, :create]
  before_action :set_concern, only: [:show, :edit, :update, :destroy, :reopen, :close]
  before_action :restrict_user, only: [:new, :create]

  def index
    @q = Concern.all.includes(:user).order(status: :asc).ransack(params[:q])
    @concerns = @q.result(distinct: true)
    @current_user_concerns = @tenant.concerns.order(status: :asc)
  end

  def show
    @tenant = User.find(@concern.user_id)
  end

  def new
    @concern = @tenant.concerns.build
  end

  def create
    @concern = @tenant.concerns.build(concern_params)
    if @concern.save
      redirect_to concern_path(@concern), notice: 'Ticket Created'
    else
      render :new
    end
  end

  def close
  end

  def update
    if @concern.update(concern_params)
      redirect_to concern_path(@concern), notice: 'Ticket Closed'
    else
      render :close
    end
  end
  
  def reopen
    if @concern.user_id == current_user.id
      @concern.open!
      redirect_to concern_path(@concern), notice: 'Ticket Re-Opened'
    else
      redirect_to concerns_path, alert: 'Access Denied'
    end
  end

  
  private
  
  def restrict_user
    if !current_user.tenant?
      redirect_to concerns_path, alert: 'Access Denied'
    end
  end

  def get_tenant
    @tenant = current_user
  end

  def set_concern
    @concern = Concern.find(params[:id])
  end

  def concern_params
    params.require(:concern).permit(:user_id, :title, :description, :status, :assisted_by, :remarks)
  end
  
end
