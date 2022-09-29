class RoomsController < ApplicationController
  before_action :get_branch, only: [:index, :show]

  def index
    @rooms = @branch.rooms
  end

  def show
    @room = @branch.rooms.find(params[:id])
    tenants = @room.users
    @active = []
    @inactive = []
    tenants.each do |tenant|
      tenant.bookings.each do |booking|
        if booking.active?
          @active.push(tenant)
        else
          @inactive.push(tenant)
        end
      end
    end
  end

  def available
    # @q = Branch.joins(:rooms).where(rooms: { available_count: > 0 }).ransack(params[:q])
    @q = Room.includes(:branch).where('available_count > 0').order(:room_code).ransack(params[:q])
    @available_rooms = @q.result(distinct: true)
    @branches = Branch.all
  end

  private

  def get_branch
    @branch = Branch.find(params[:branch_id])
  end

end
