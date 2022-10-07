class TenantsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_tenants
  before_action :check_restriction

  def index
    @q = @tenants.ransack(params[:q])
    @tenants = @q.result(distinct: true)
  end
  
  def new_tenants
    @q = @tenants.where.missing(:bookings).ransack(params[:q])
    @tenants = @q.result(distinct: true)
  end

  def active
    @q = @tenants.includes(:bookings).where(bookings: {status: 'active'}).ransack(params[:q])
    @tenants = @q.result(distinct: true)
  end

  def show
    @tenant = User.find(params[:id])
    @active_booking = @tenant.bookings.includes(room: [:branch]).find_by(status: 'active')
  end


  def activate
    @tenant = User.find(params[:id])
    @tenant.active!
    redirect_to tenant_path(@tenant), notice: 'Tenant Activated'
  end

  def get_tenants
    @tenants = User.where(role: 'tenant')
  end

  private
  
  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

end




