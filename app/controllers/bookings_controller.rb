class BookingsController < ApplicationController
  before_action :get_tenant, only: [:index, :new, :create]
  before_action :set_booking, only: [:edit, :update, :destroy, :deactivate]

  def show
    @booking = Booking.includes(:user, room: [:branch]).find(params[:id])
    # @tenant = User.find(@booking.user_id)
    # @room = Room.find(@booking.room_id)
    # @branch = Branch.find(@room.branch_id)
    @invoices = @booking.invoices.order(status: :asc)
  end

  def new
    @booking = @tenant.bookings.build
    @available_rooms = Room.where('available_count > 0').order(room_code: :asc)
  end

  def create
    @booking = @tenant.bookings.build(booking_params)
    if @booking.save!
      @booking.set_processed_by(current_user.email)
      @booking.update_room_occupants
      redirect_to booking_path(@booking), notice: 'Booking Added'
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @booking.update(booking_params)
      if @booking.inactive?
        @booking.set_room_occupants_once_inactive_or_destroyed
      end
      redirect_to booking_path(@booking), notice: 'Booking Updated'
    else
      render :edit
    end
  end

  def deactivate
    @active_invoice = @booking.invoices.where(status: 'active')

    if @active_invoice.present?
      redirect_to booking_path(@booking), notice: 'Failed. Tenant has an active Invoice'
    else
      @booking.inactive!
      @booking.set_room_occupants_once_inactive_or_destroyed
      @booking.deactivate_tenant_account
      redirect_to booking_path(@booking), notice: 'Booking deactivated'
    end
  end

  private

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
