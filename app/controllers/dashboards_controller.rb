class DashboardsController < ApplicationController

  def index
    @announcement = Announcement.last
    @available_rooms_count = Room.where('(capacity - occupants) > 0').count

    if current_user.role != 'tenant'
      # redirect_to staff_dashboard_path
      render "dashboards/staff"
    else 
      # redirect_to tenant_dashboard_path
      render "dashboards/tenant"
    end
  end
  
end
