class InquiriesController < ApplicationController
  
  def index
    @inquiries = Inquiry.all 
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save!
      redirect_to root_path, notice: 'Thank you for your interest'
    else
      render :new
    end
  end

  def edit
    @inquiry = Inquiry.find(params[:id]) 
  end

  def update
    @inquiry = Inquiry.find(params[:id]) 

    if @inquiry.update(inquiry_params)
      redirect_to root_path, notice: 'Updated Successfully'
    else
      render :edit
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:email, :first_name, :last_name, :gender, :contact_no, :occupation, :location_preference, :room_type, :move_in_date )
  end

end
