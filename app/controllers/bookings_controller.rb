class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_restriction, except: [:index]
  before_action :check_if_not_tenant, only: [:index]
  before_action :get_tenant, only: [:new, :create]
  before_action :set_booking, only: [:edit, :update, :deactivate]

  def index
    @bookings = current_user.bookings.order(status: :asc)
  end

  def show
    @booking = Booking.includes(:user, room: [:branch]).find(params[:id])
    @invoices = @booking.invoices.order(status: :asc)
  end

  def new
    @booking = @tenant.bookings.build
    @available_rooms = Room.where('available_count > 0').order(room_code: :asc)
  end

  def create
    @booking = @tenant.bookings.build(booking_params)
    if @booking.save
      @booking.set_processed_by(current_user.email)
      redirect_to tenant_path(@tenant), notice: 'Booking Created'
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path, notice: 'Booking Updated'
    else
      render :edit
    end
  end

  def deactivate
    @active_invoice = @booking.invoices.where(status: 'active')

    if @active_invoice.present?
      redirect_to tenants_path, notice: 'Failed. Tenant has an active Invoice'
    else
      @booking.inactive!
      redirect_to tenants_path, notice: 'Booking Deactivated'
    end
  end

  private

  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

  def check_if_not_tenant
    if !current_user.tenant?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

  def get_tenant
    @tenant = User.find(params[:tenant_id])
  end

  def set_booking
    # @booking = @user.bookings.find(params[:id])
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:room_id, :user_id, :move_in_date, :move_out_date, :due_date, :status, :processed_by)
  end

end
