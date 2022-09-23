class PaymentsController < ApplicationController
  before_action :get_invoice

  def index
  end

  def show
    @payment = @invoice.payment
  end

  def new
    @payment = @invoice.build_payment
  end

  def create
    @payment = @invoice.build_payment(payment_params)
    check_if_by_cashier
    if @payment.save!
      redirect_to invoice_payment_path(@invoice)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def get_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end

  private

  def payment_params
    params.require(:payment).permit(:invoice_id, :amount, :payment_mode, :status, :remarks, :initiated_by, :processed_by)
  end

  def check_if_by_cashier
    if current_user.cashier?
      @payment.status = 'approved'
      @payment.set_processed_by(current_user.email)
    end
  end
end
