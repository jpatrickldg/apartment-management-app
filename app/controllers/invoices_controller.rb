class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_restriction, except: [:index, :show, :links, :payment, :pdf]
  before_action :check_ownership, only: [:show, :payment]
  before_action :check_if_receptionist, only: [:new, :create]
  before_action :get_booking, only: [:new, :create]
  before_action :set_invoice, only: [:edit, :update, :pdf] 

  def index
    @q = Invoice.includes(booking: [:user]).ransack(params[:q])
    @invoices = @q.result(distinct: true).order(created_at: :desc)
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

  def pdf
    @booking = Booking.find(@invoice.booking_id)
    @user = User.find(@booking.user_id)
    pdf = Prawn::Document.new 

    pdf.text "INVOICE #{@invoice.id}", size: 16, style: :bold
    pdf.move_down 10
    pdf.text "Status: #{@invoice.status.upcase}"
    pdf.text "Invoice Date: #{@invoice.created_at.strftime("%y-%b-%d")}"
    pdf.text "Due Date: #{@booking.due_date.strftime("%y-%b-%d")}"
    pdf.move_down 10
    pdf.text "Billed To", style: :bold
    pdf.move_down 2
    pdf.text "#{@user.first_name.capitalize} #{@user.first_name.capitalize}"
    pdf.text @user.address.capitalize
    pdf.text @user.email
    pdf.move_down 10
    pdf.text "Description", style: :bold
    pdf.move_down 2
    pdf.text "Period: #{@invoice.date_from.strftime("%y-%b-%d")} to #{@invoice.date_to.strftime("%y-%b-%d")}"
    pdf.text "Remarks: #{@invoice.remarks.capitalize}"
    pdf.move_down 10
    pdf.text "Fees Breakdown", style: :bold
    pdf.move_down 2
    pdf.text "Room Rate: #{@invoice.room_rate}"
    pdf.text "Meralco: #{@invoice.electricity_bill}"
    pdf.text "Maynilad: #{@invoice.water_bill}"
    pdf.move_down 10
    pdf.text "Total Amount", style: :bold
    pdf.move_down 2
    pdf.text "#{@invoice.total_amount}", size: 16, style: :bold
    pdf.move_down 20
    if @invoice.paid?
      pdf.text "Payment Details", size: 14, style: :bold
      pdf.move_down 10
      pdf.text "Payment Date: #{@invoice.payment.created_at.strftime("%y-%b-%d")}"
      pdf.text "Mode of Payment: #{@invoice.payment.payment_mode.capitalize}"
      pdf.text "Remarks: #{@invoice.payment.remarks.capitalize}"
      pdf.text "Total Amount Paid: #{@invoice.payment.amount}"
    end
    
    send_data(pdf.render,
              filename: "Invoice_#{@invoice.id}.pdf",
              type: 'application/pdf',
              disposition: 'inline')
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