class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_branch, only: [:index, :show]
  before_action :check_restriction

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
    @q = Room.includes(:branch).where('available_count > 0').order(:room_code).ransack(params[:q])
    @available_rooms = @q.result(distinct: true)
    @branches = Branch.all
  end

  private

  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

  def get_branch
    @branch = Branch.find(params[:branch_id])
  end

end
