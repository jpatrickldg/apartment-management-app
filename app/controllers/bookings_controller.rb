class BookingsController < ApplicationController
  before_action :get_user
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def show
    
  end

  def new
    @booking = @user.build_booking
    @rooms = Room.all
    @available_rooms = Room.where(:capacity > :occupants)
  end

  def create
    @booking = @user.build_booking(booking_params)
    if @booking.save!
      redirect_to root_path, notice: 'Booking Added'
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @booking.update(booking_params)
      redirect_to root_path, notice: 'Booking Updated'
    else
      render :edit
    end
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def set_booking
    @booking = @user.booking
  end

  def booking_params
    params.require(:booking).permit(:room_id, :user_id, :move_in_date, :move_out_date, :due_date, :is_active)
  end

end
