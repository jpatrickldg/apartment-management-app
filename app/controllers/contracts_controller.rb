class ContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contract, only: %i[ show edit update destroy ]
  before_action :check_ownership, only: [:show]

  # GET /contracts or /contracts.json
  def index
    @q = Contract.ransack(params[:q])
    @contracts = @q.result(distinct: true)
    # @current_user_contracts = current_user.contracts.order(status: :asc)
    if current_user.tenant?
      @contracts = current_user.contracts.where(status: 'active')
      if @contracts.count == 1
        redirect_to contract_path(@contracts.first)
      end
    end
  end

  # GET /contracts/1 or /contracts/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    def check_ownership
      @contract = Contract.includes(booking: [:user]).find(params[:id])
      if current_user.tenant? && @contract.booking.user.id != current_user.id
        redirect_to authenticated_root_path, alert: 'Access Denied'
      end
    end

    # Only allow a list of trusted parameters through.
    def contract_params
      params.require(:contract).permit(:tenant_first_name, :tenant_last_name, :tenant_address, :room_code, :valid_from, :valid_to, :monthly_rate, :date_signed, :status, :booking_id)
    end
end
