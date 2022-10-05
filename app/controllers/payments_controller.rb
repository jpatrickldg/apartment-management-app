class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_receptionist, only: [:new, :create, :edit, :update]
  before_action :check_ownership, only: [:show]
  before_action :get_invoice, only: [:new, :create]
  before_action :set_payment, only: [:change_proof, :update_proof, :approve, :approve_payment]
  skip_before_action :verify_authenticity_token, :authenticate_user!, only: [:listen]

  def index
    @q = Payment.ransack(params[:q])
    @payments = @q.result(distinct: true)
    @current_user_payments = current_user.payments
  end

  def listen
    data = JSON.parse(request.body.read)
    type = data['data']['attributes']['type']
    
    if type == "link.payment.paid"
      source_id = data['data']['attributes']['data']['id']
      amount = data['data']['attributes']['data']['attributes']['amount']
      
      #get invoice_id passed as description 
      invoice_id = data['data']['attributes']['data']['attributes']['description'].to_i

      payment_type = data['data']['attributes']['data']['attributes']['payments'][0]['data']['attributes']['source']['type']

      Payment.create!(
        invoice_id: invoice_id,
        amount: amount / 100,
        payment_mode: 'paymongo',
        status: 'approved',
        remarks: payment_type,
        initiated_by: 'tenant'
      )
    end
    render :json => {:status => 200}
  end

  def show
    @payment = Payment.includes(:invoice).find(params[:id])
  end

  def new
    @payment = @invoice.build_payment
  end

  def create
    @payment = @invoice.build_payment(payment_params)
    check_if_by_cashier_admin_owner
    @payment.initiated_by = current_user.email
    if @payment.save
      redirect_to payment_path(@payment), notice: 'Payment Submitted'
    end
  end

  def change_proof
  end

  def approve
  end

  def update_proof
    if @payment.update(payment_params)
      redirect_to payment_path(@payment), notice: 'Proof Updated'
    else
      render :change_proof, notice: 'Error'
    end
  end

  def approve_payment
    @payment.status = 'approved'
    if @payment.update(payment_params)
      @payment.set_processed_by(current_user.email)
      redirect_to payment_path(@payment), notice: 'Payment Approved'
    else
      render :approve, notice: 'Error'
    end
  end

  private

  def check_ownership
    @payment = Payment.includes(invoice: [booking: [:user]]).find(params[:id])
    if current_user.tenant? && @payment.invoice.booking.user.id != current_user.id
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

  def check_if_receptionist
    if current_user.receptionist?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

  def get_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:invoice_id, :amount, :payment_mode, :status, :remarks, :initiated_by, :processed_by, :proof)
  end

  def check_if_by_cashier_admin_owner
    if current_user.cashier? || current_user.owner? || current_user.admin?
      @payment.status = 'approved'
      @payment.remarks = 'Cash'
      @payment.set_processed_by(current_user.email)
    end
  end
end