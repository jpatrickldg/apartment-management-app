class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = Review.all
    @review = current_user.review
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user

    if @review.save
      # Handle successful review submission
      redirect_to reviews_path, notice: 'Successfully submitted review.'
    else
      # Handle review submission failure
      redirect_to reviews_path, alert: 'Something went wrong. Please try again later.'
    end
  end

  private

  def review_params
    params.require(:review).permit(:maintenance_satisfaction, :responsiveness_effectiveness, :common_area_cleanliness, :lease_renewal_likelihood, :recommend_apartment, :comment)
  end
end
