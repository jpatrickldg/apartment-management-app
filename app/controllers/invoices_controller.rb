class InvoicesController < ApplicationController
  before_action :get_booking, only: [:new, :create]
  before_action :set_invoice, only: [:edit, :update, :destroy] 

  def index
    @q = Invoice.ransack(params[:q])
    @invoices = @q.result(distinct: true)
    @current_user_invoices = current_user.invoices
  end

  def show
    @invoice = Invoice.includes(booking: [:user]).find(params[:id])
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
