class BookingsController < ApplicationController
  before_action :get_tenant, only: [:index, :new, :create]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def show
    @tenant = User.find(@booking.user_id)
    @room = Room.find(@booking.room_id)
    @branch = Branch.find(@room.branch_id)
  end

  def new
    @booking = @tenant.bookings.build
    @rooms = Room.all
    @available_rooms = Room.where('available_count > 0')
  end

  def create
    @booking = @tenant.bookings.build(booking_params)
    email = @tenant.email
    if @booking.save!
      @booking.set_processed_by(email)
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
    @booking = Booking.find(params[:id])
    @booking.inactive!
    @booking.set_room_occupants_once_inactive_or_destroyed
    redirect_to booking_path(@booking), notice: 'Booking deactivated'
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
