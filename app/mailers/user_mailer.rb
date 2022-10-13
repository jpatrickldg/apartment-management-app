class UserMailer < ApplicationMailer
  default from: 'mwpmi@test.com'

  def due_reminder
    @user = params[:user]
    @booking = @user.bookings.find_by(status: 'active')
    mail(to: @user.email, subject: 'A gentle payment reminder')
  end
end
