class RoomsController < ApplicationController
  before_action :get_branch

  def index
    @rooms = @branch.rooms
  end

  def show
    @room = @branch.rooms.find(params[:id])
  end

  private

  def get_branch
    @branch = Branch.find(params[:branch_id])
  end

end
