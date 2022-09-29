class InvoicesController < ApplicationController
  before_action :get_booking, only: [:new, :create]
  before_action :set_invoice, only: [:edit, :update, :destroy] 

  def index
    @q = Invoice.includes(booking: [:user]).ransack(params[:q])
    @invoices = @q.result(distinct: true)
    @current_user_invoices = current_user.invoices
  end

  def active
    @invoices = Invoice.includes(booking: [:user]).where(status: 'active')
  end

  def show
    @invoice = Invoice.includes(booking: [:user]).find(params[:id])
    @booking = Booking.find(@invoice.booking_id)
  end

  def new
    @invoice = @booking.invoices.build 
  end

  def create
    @invoice = @booking.invoices.build(invoice_params)
    if @invoice.save
      @invoice.set_processed_by(current_user.email)
      redirect_to booking_path(@booking), notice: 'Invoice Added'
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to invoice_path(@invoice), notice: 'Invoice Updated'
    else
      render :edit
    end
    
  end

  def destroy
  end

  def get_booking
    @booking = Booking.includes(:room).find(params[:booking_id])
  end
  
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:booking_id, :water_bill, :electricity_bill, :total_amount, :date_from, :date_to, :remarks, :processed_by, :status, :room_rate )
  end
  

end
