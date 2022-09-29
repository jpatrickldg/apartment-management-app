class InquiriesController < ApplicationController
  
  def index
    @q = Inquiry.ransack(params[:q])
    @inquiries = @q.result(distinct: true)
    @open = Inquiry.where(status: 'open')
    @on_going = Inquiry.where(status: 'on_going').where(processed_by: current_user.email)
    @close = Inquiry.where(status: 'closed').where(processed_by: current_user.email)
  end

  def show
    @inquiry = Inquiry.find(params[:id])
    if current_user.email != @inquiry.processed_by && !current_user.admin? && !current_user.owner?
      redirect_to inquiries_path, notice: 'Access Denied'
    end
    
    
  end

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save!
      redirect_to authenticated_root_path, notice: 'Thank you for your interest'
    else
      render :new
    end
  end

  def close
    @inquiry = Inquiry.find(params[:id]) 
  end

  def update
    @inquiry = Inquiry.find(params[:id]) 
    if @inquiry.update(inquiry_params)
      redirect_to authenticated_root_path, notice: 'Updated Successfully'
    else
      render :close
    end
  end

  def assists
    @inquiry = Inquiry.find(params[:id])  
    @inquiry.on_going!
    @inquiry.set_processed_by_if_on_going(current_user.email)
    redirect_to inquiries_path
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:email, :first_name, :last_name, :gender, :contact_no, :occupation, :location_preference, :room_type, :move_in_date, :status, :contract_signed )
  end

end
