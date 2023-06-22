class InquiriesController < ApplicationController
  before_action :authenticate_user!, except: [:inquire, :create]
  before_action :check_restriction, except: [:inquire, :create]
  # before_action :check_if_signed_in, only: [:inquire, :create]
  before_action :set_inquiry, only: [:show, :close, :update, :assists]
  skip_before_action :verify_authenticity_token, only: [:create]
  layout "landing_page", only: [:inquire, :create]

  def index
    @q = Inquiry.order(created_at: :desc).ransack(params[:q])
    @inquiries = @q.result(distinct: true)
    @open = Inquiry.where(status: 'open').order(created_at: :desc)
    @on_going = Inquiry.where(status: 'on_going').where(processed_by: current_user.email).order(created_at: :desc)
    @close = Inquiry.where(status: 'closed').where(processed_by: current_user.email).order(created_at: :desc)
  end

  def show
    if current_user.email != @inquiry.processed_by && !current_user.owner?
      redirect_to inquiries_path, alert: 'Access Denied'
    end

    # if current_user.email != @inquiry.processed_by
    # # if current_user.email != @inquiry.processed_by && !current_user.admin? && !current_user.owner?
    #   redirect_to inquiries_path, alert: 'Access Denied'
    # end
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    # if @inquiry.save
    #   redirect_to inquiry_submitted_path
    # else
    #   render 'home/index'
    # end
    if @inquiry.save
      # Successful creation of the inquiry
      render json: { message: 'Inquiry created successfully' }, status: :created
    else
      # Failed to create the inquiry
      render json: { errors: @inquiry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def close
    if current_user.email != @inquiry.processed_by && !current_user.admin? && !current_user.owner?
      redirect_to inquiries_path, alert: 'Access Denied'
    end
  end

  def update 
    if @inquiry.update(inquiry_params)
      if @inquiry.contract_signed 
        create_user_from_inquiry(@inquiry)
        redirect_to authenticated_root_path, notice: 'Inquiry Closed and User Added'
      else
        redirect_to authenticated_root_path, notice: 'Inquiry Closed'
      end
    else
      render :close
    end
  end

  def assists  
    @inquiry.on_going!
    @inquiry.set_processed_by_if_on_going(current_user.email)
    redirect_to inquiries_path
  end

  private

  def create_user_from_inquiry(inquiry)
    # Retrieve necessary information from the inquiry to create the user
    random_password = SecureRandom.base64(8)

    user_attributes = {
      email: inquiry.email,
      password: random_password,
      password_confirmation: random_password,
      confirmed_at: Time.current,
      first_name: inquiry.first_name,
      last_name: inquiry.last_name,
      gender: inquiry.gender,
      birthdate: inquiry.birthdate,
      contact_no: inquiry.contact_no,
      role: "tenant",
      address: inquiry.address,
      occupation: inquiry.occupation
    }

    # Create the user
    user = User.create(user_attributes)
    # You might want to handle errors or validations when creating the user

    # Send an email with the user's credentials
    UserMailer.user_credentials_email(user).deliver_now
  end

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def check_restriction
    if current_user.tenant?
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

  def check_if_signed_in
    if user_signed_in?
      redirect_to authenticated_root_path, alert: 'Access Denied'
    end
  end

  def inquiry_params
    params.require(:inquiry).permit(:email, :first_name, :last_name, :birthdate, :gender, :contact_no, :occupation, :location_preference, :room_type, :move_in_date, :status, :contract_signed, :address )
  end
end
