class BranchesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_restriction

  def index
    @branches = Branch.all
  end

  def show
    @branch = Branch.find(params[:id])
  end

  private

  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, notice: 'Access Denied'
    end
  end

end
