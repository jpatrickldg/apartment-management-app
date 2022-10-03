class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_restriction, except: [:index, :show]
  before_action :check_ownership, only: [:show]
  before_action :get_tenant, only: [:new, :create]
  before_action :set_booking, only: [:edit, :update, :deactivate, :update_deactivate]
  before_action :check_active_invoice, only: [:deactivate, :update_deactivate]

  def index
    @q = Booking.includes(:user).ransack(params[:q])
    @bookings = @q.result(distinct: true)
    @current_user_bookings = current_user.bookings.order(status: :asc)
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
  end

  def update_deactivate
    @booking.status = 'inactive'
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: 'Booking Deactivated'
    else
      render :deactivate
    end
  end

  private

  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

  def check_ownership
    @booking = Booking.includes(:user).find(params[:id])
    if current_user.tenant? && @booking.user.id != current_user.id
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

  def check_active_invoice
    @booking = Booking.find(params[:id])
    @active_invoice = @booking.invoices.where(status: 'active')
    if @active_invoice.present?
      redirect_to booking_path(@booking), notice: 'Failed. Tenant has an active Invoice'
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
