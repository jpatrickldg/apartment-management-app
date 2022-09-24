class TenantsController < ApplicationController

  def index
    @tenants = User.where(role: 'tenant')
    @tenants_with_booking = @tenants.joins(:bookings).where(bookings: {status: 'active'})
    @new_tenants = @tenants.where.missing(:bookings)
    @returnees = @tenants.joins(:bookings).where(bookings: {status: 'inactive'})
    @inactive_tenants = @tenants.where(status: 'inactive')
  end
  
  def show
    @tenant = User.find(params[:id])
    @active = @tenant.bookings.find_by(status: 'active')
    @room = Room.find(@active.room_id)
    @branch = Branch.find(@room.branch_id)
  end

  def activate
    @tenant = User.find(params[:id])
    @tenant.active!
    redirect_to tenant_path(@tenant)
  end
  

end




