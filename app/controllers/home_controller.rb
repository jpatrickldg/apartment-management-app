class HomeController < ApplicationController
  layout "landing_page"

  def index
    redirect_to new_user_session_path
  end

  def inquiry_submitted
    
  end
  
end
