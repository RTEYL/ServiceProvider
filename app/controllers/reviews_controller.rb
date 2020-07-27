class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @service = Service.find_by_id(params[:service_id])
  end

  def create
    binding.pry
    @service = Service.find_by_id(params[:service_id])
    @review = @service.reviews.build(review_params)
    if @review.save
      redirect_to user_path(current_user)
    else
     render :new
    end
  end

  def update

  end

  def destroy

  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :comment).merge(user_id: current_user.id)
  end

end
