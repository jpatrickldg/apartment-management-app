class PaymentsController < ApplicationController
  before_action :get_invoice, only: [:new, :create]
  before_action :set_payment, only: [:edit, :update, :approve]

  def index
    @q = Payment.ransack(params[:q])
    @payments = @q.result(distinct: true)
    @current_user_payments = current_user.payments
  end

  def show
    @payment = Payment.includes(:invoice).find(params[:id])
  end

  def new
    @payment = @invoice.build_payment
  end

  def create
    @payment = @invoice.build_payment(payment_params)
    check_if_by_cashier
    if @payment.save
      redirect_to payment_path(@payment), notice: 'Payment Submitted'
    end
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      redirect_to payment_path(@payment), notice: 'Payment Approved'
    else
      render :approve, notice: 'Error'
    end
  end

  def destroy
  end

  def get_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end

  def approve
  end
  

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:invoice_id, :amount, :payment_mode, :status, :remarks, :initiated_by, :processed_by, :proof)
  end

  def check_if_by_cashier
    if current_user.cashier?
      @payment.status = 'approved'
      @payment.remarks = 'Cashier'
      @payment.set_processed_by(current_user.email)
    end
  end
end
