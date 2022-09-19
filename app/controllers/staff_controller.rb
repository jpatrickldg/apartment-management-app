class StaffController < ApplicationController

  def dashboard
    @announcement = Announcement.last
  end

  def profile
    @user = current_user
  end

  def inquiries
    @inquiries = Inquiry.all
  end

  def tenants
    @users = User.where(role: 'tenant')
  end

  def expenses
    @expenses = Expense.all
  end

  def concerns
    @concerns = Concern.all
  end

end
