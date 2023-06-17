class HomeController < ApplicationController
  layout "landing_page"

  def index
    redirect_to new_user_session_path
    @inquiry = Inquiry.new
  end

  def inquiry_submitted
    
  end
  
end
