class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_restriction, except: [:index, :show, :links, :payment]
  before_action :check_ownership, only: [:show, :payment]
  before_action :check_if_receptionist, only: [:new, :create]
  before_action :get_booking, only: [:new, :create]
  before_action :set_invoice, only: [:edit, :update] 

  def index
    @q = Invoice.includes(booking: [:user]).ransack(params[:q])
    @invoices = @q.result(distinct: true)
    @current_user_invoices = current_user.invoices
  end

  def links
    amount = params[:amount].to_f * 100
    description = params[:description]
    response = Paymongo::Links::Create.call(amount, description)
    url = response['data']['attributes']['checkout_url']
    redirect_to url, allow_other_host: true
  end

  def unpaid
    @q = Invoice.includes(booking: [:user]).where(status: 'unpaid').ransack(params[:q])
    @invoices = @q.result(distinct: true)
  end

  def show
    @invoice = Invoice.includes(booking: [:user]).find(params[:id])
    @booking = Booking.find(@invoice.booking_id)
  end

  def payment
    @invoice = Invoice.includes(booking: [:user]).find(params[:id])
    if @invoice.paid?
      redirect_to authenticated_root_path, alert: 'Invalid Request'
    end
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
    if @invoice.processed_by != current_user.email 
      redirect_to invoice_path(@invoice), alert: 'Access Denied'
    end
  end

  def update
    if @invoice.processed_by != current_user.email 
      redirect_to invoice_path(@invoice), alert: 'Access Denied'
    else
      if @invoice.update(invoice_params)
        redirect_to invoice_path(@invoice), notice: 'Invoice Updated'
      else
        render :edit
      end
    end
  end

  def send_email_reminder
    @invoice = Invoice.includes(booking: [:user]).find(params[:id])
    @user = @invoice.booking.user
    UserMailer.with(user: @user).due_reminder.deliver_now
    redirect_to invoice_path(@invoice), notice: 'Payment Reminder Sent'
  end

  private

  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

  def check_ownership
    @invoice = Invoice.includes(booking: [:user]).find(params[:id])
    if current_user.tenant? && @invoice.booking.user.id != current_user.id
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

  def check_if_receptionist
    if current_user.receptionist?
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

  def get_booking
    @booking = Booking.includes(:room).find(params[:booking_id])
  end
  
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:booking_id, :water_bill, :electricity_bill, :total_amount, :date_from, :date_to, :remarks, :processed_by, :status, :room_rate )
  end
end