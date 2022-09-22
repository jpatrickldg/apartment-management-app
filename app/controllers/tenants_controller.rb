class TenantsController < ApplicationController

  def index
    @tenants = User.where(role: 'tenant')
    @tenants_with_booking = @tenants.joins(:bookings).where(bookings: {status: 'active'})
    @new_tenants = @tenants.where.missing(:bookings)
  end
  
  def show
    @tenant = User.find(params[:id])
    @active = @tenant.bookings.where(status: 'active').last
  end

end




