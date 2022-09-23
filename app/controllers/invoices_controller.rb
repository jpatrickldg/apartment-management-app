class InvoicesController < ApplicationController
  before_action :get_booking, only: [:index, :new, :create]
  before_action :set_invoice, only: [:show, :edit, :update, :destroy] 

  def index
    @invoices = @booking.invoices
    @user = User.find(@booking.user_id)
    @room = Room.find(@booking.room_id)
    @branch = Branch.find(@room.branch_id)
  end

  def show
    @booking = Booking.find(@invoice.booking_id)
  end

  def new
    @invoice = @booking.invoices.build 
  end

  def create
    @invoice = @booking.invoices.build(invoice_params)
    if @invoice.save!
      @invoice.set_processed_by(current_user.email)
      redirect_to authenticated_root_path, notice: 'Invoice Added'
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to authenticated_root_path, notice: 'Invoice Updated'
    else
      render :edit
    end
    
  end

  def destroy
  end

  def get_booking
    @booking = Booking.find(params[:booking_id])
  end
  
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:booking_id, :water_bill, :electricity_bill, :total_amount, :date_from, :date_to, :remarks, :processed_by, :status, :room_rate )
  end
  

end
