class DashboardsController < ApplicationController

  def index
    announcement = Announcement.where(status: 'published')
    @latest_published_announcement = announcement.order(updated_at: :asc).last

    @available_rooms_count = Room.where('available_count > 0').count
    @available_space_count = Room.all.sum(:available_count)
    @user = current_user
    @pending_payments = Payment.all.where(status: 'pending')
    @active_invoices = @user.invoices.where(status: 'active')

    if current_user.tenant?
      # redirect_to staff_dashboard_path
      render "dashboards/tenant"
    elsif current_user.cashier?
      # redirect_to tenant_dashboard_path
      render "dashboards/cashier"
    else
      render "dashboards/staff"
    end
  end
  
end
