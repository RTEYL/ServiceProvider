class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_service
  skip_before_action :find_service, only: :update

  def index
  end

  def new
    @review = Review.new
  end

  def create
    @review = @service.reviews.build(review_params)
    if @review.save
      redirect_to user_path(current_user)
      flash[:notice] = "Thank you for reviewing #{@service.user.fullname}'s service'"
    else
      custom_error_messages("alert", @review)
      render :new
    end
  end

  def update
    @review = Review.find_by_id(params[:id])
    @review.update(review_params)
    if @review.save
      redirect_to service_reviews_path(params[:service_id])
    else
      custom_error_messages("alert", @review)
      redirect_to service_reviews_path(params[:service_id])
    end
  end

  def find_service
    @service = Service.find_by_id(params[:service_id])
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :comment).merge(user_id: current_user.id)
  end

end
