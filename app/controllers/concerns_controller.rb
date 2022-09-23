class ConcernsController < ApplicationController
  before_action :get_tenant, only: [:index, :new, :create]
  before_action :set_concern, only: [:show, :edit, :update, :destroy, :close, :resolve, :reopen]

  def index
    @concerns = Concern.all
    @current_user_concerns = @tenant.concerns
  end

  def show
    @tenant = User.find(@concern.user_id)

  end

  def new
    @concern = @tenant.concerns.build
  end

  def create
    @concern = @tenant.concerns.build(concern_params)
    if @concern.save!
      redirect_to concern_path(@concern), notice: 'Concern Ticket Created'
    else
    end
  end

  def edit
  end

  def update
    if @concern.update(concern_params)
      redirect_to authenticated_root_path, notice: 'Concern Ticket Updated'
    else
      render :edit
    end
  end

  def destroy
  end

  def close
    @concern.closed!
    redirect_to concern_path(@concern), notice: 'Ticket Closed'
  end

  def resolve
    @concern.resolved!
    redirect_to concern_path(@concern), notice: 'Ticket Resolved'
  end
  
  def reopen
    @concern.open!
    redirect_to concern_path(@concern), notice: 'Ticket Re-Opened'
  end

  def get_tenant
    @tenant = current_user
  end

  def set_concern
    @concern = Concern.find(params[:id])
  end

  private

  def concern_params
    params.require(:concern).permit(:user_id, :title, :description, :status, :assisted_by)
  end
  

end
