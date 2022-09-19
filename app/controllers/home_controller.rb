class HomeController < ApplicationController
  def index
  end

  def dashboard
    if current_user.role != 'tenant'
      redirect_to staff_dashboard_path
    else 
      redirect_to tenant_dashboard_path
    end
  end
end
