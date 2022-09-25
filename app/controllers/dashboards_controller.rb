class DashboardsController < ApplicationController

  def index
    announcement = Announcement.where(status: 'published')
    @latest_published_announcement = announcement.order(updated_at: :asc).last

    @tenants_count = User.where(role: 'tenant').joins(:bookings).where(bookings: {status: 'active'}).count
    @available_rooms_count = Room.where('available_count > 0').count
    @available_space_count = Room.all.sum(:available_count)
    @pending_payments = Payment.all.where(status: 'pending')
    @active_invoices = current_user.invoices.includes(:booking).where(status: 'active')

    if current_user.tenant?
      # redirect_to staff_dashboard_path
      render "dashboards/tenant"
    elsif current_user.cashier?
      # redirect_to tenant_dashboard_path
      render "dashboards/cashier"
    elsif current_user.receptionist?
      render "dashboards/receptionist"
    elsif current_user.admin?
      render "dashboards/admin"
    elsif current_user.owner?
      render "dashboards/owner"
    end
  end
  
end
