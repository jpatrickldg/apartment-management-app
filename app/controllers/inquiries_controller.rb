class InquiriesController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :check_restriction, except: [:new, :create]
  before_action :check_if_signed_in, only: [:new, :create]
  before_action :set_inquiry, only: [:show, :close, :update, :assists]
  layout "landing_page", only: [:new]

  def index
    @q = Inquiry.ransack(params[:q])
    @inquiries = @q.result(distinct: true)
    @open = Inquiry.where(status: 'open')
    @on_going = Inquiry.where(status: 'on_going').where(processed_by: current_user.email)
    @close = Inquiry.where(status: 'closed').where(processed_by: current_user.email)
  end

  def show
    if current_user.email != @inquiry.processed_by && !current_user.admin? && !current_user.owner?
      redirect_to inquiries_path, alert: 'Access Denied'
    end
  end

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save
      redirect_to authenticated_root_path, notice: "Inquiry Submitted"
    else
      render :new
    end
  end

  def close
    if current_user.email != @inquiry.processed_by && !current_user.admin? && !current_user.owner?
      redirect_to inquiries_path, alert: 'Access Denied'
    end
  end

  def update 
    if @inquiry.update(inquiry_params)
      redirect_to authenticated_root_path, notice: 'Inquiry Closed'
    else
      render :close
    end
  end

  def assists  
    @inquiry.on_going!
    @inquiry.set_processed_by_if_on_going(current_user.email)
    redirect_to inquiries_path
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

  def check_if_signed_in
    if user_signed_in?
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

  def inquiry_params
    params.require(:inquiry).permit(:email, :first_name, :last_name, :gender, :contact_no, :occupation, :location_preference, :room_type, :move_in_date, :status, :contract_signed )
  end
end
