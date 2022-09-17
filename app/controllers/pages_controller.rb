class PagesController < ApplicationController
  def home
  end

  def new_inquiry
    @new_inquiry = Inquiry.new
  end

  def create_inquiry
    @new_inquiry = Inquiry.new(inquiry_params)
    if @new_inquiry.save!
      redirect_to root_path, notice: 'Inquiry Added'
    else
      render :new_inquiry
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:email, :first_name, :last_name, :gender, :contact_no, :occupation, :location_preference, :room_type, :move_in_date )
  end

end
