class DashboardsController < ApplicationController

  def index
    @announcement = Announcement.where(status: :published).last
    @available_rooms_count = Room.where('available_count > 0').count

    if current_user.tenant?
      # redirect_to staff_dashboard_path
      render "dashboards/tenant"
    else 
      # redirect_to tenant_dashboard_path
      render "dashboards/staff"
    end
  end
  
end
