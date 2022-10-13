class HomeController < ApplicationController
  layout "landing_page"

  def index
    @inquiry = Inquiry.new
  end

  def inquiry_submitted
    
  end
  
end
