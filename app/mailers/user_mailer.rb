class UserMailer < ApplicationMailer
  default from: ENV['GMAIL']

  def due_reminder
    @user = params[:user]
    @booking = @user.bookings.find_by(status: 'active')
    mail(to: @user.email, subject: 'A gentle payment reminder for you incoming due date')
  end
end
