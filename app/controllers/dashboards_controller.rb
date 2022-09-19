class DashboardsController < ApplicationController

  def index
    @announcement = Announcement.last
    if current_user.role != 'tenant'
      # redirect_to staff_dashboard_path
      render "dashboards/staff"
    else 
      # redirect_to tenant_dashboard_path
      render "dashboards/tenant"
    end
  end
  
end
