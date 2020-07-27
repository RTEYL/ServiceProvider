class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in

  def index
    @service = Service.find_by_id(params[:service_id])
  end

  def new
    @review = Review.new
    @service = Service.find_by_id(params[:service_id])
  end

  def create
    @service = Service.find_by_id(params[:service_id])
    @review = @service.reviews.build(review_params)
    if @review.save
      redirect_to user_path(current_user)
    else
     render :new
    end
  end

  def update
    @review = Review.find_by_id(params[:id])
    @review.update(review_params)
    if @review.save
      redirect_to service_reviews_path(params[:service_id])
    else
      redirect_to service_reviews_path(params[:service_id])
    end
  end

  def destroy

  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :comment).merge(user_id: current_user.id)
  end

end
