class RoomsController < ApplicationController
  before_action :get_branch, only: [:index, :show]

  def index
    @rooms = @branch.rooms
  end

  def show
    @room = @branch.rooms.find(params[:id])
    @tenants = @room.users
  end

  def available
    @available_rooms = Room.where('available_count > 0')
    @branches = Branch.all
  end

  private

  def get_branch
    @branch = Branch.find(params[:branch_id])
  end

end
