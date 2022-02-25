class ReviewsController < ApplicationController
  def create
    @review = Review.new(strong_params)
    @restaurant = Restaurant.find params[:restaurant_id]
    # @review.restaurant = @restaurant
    @review.restaurant_id = @restaurant.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to restaurant_path(@restaurant) }
        format.json # Follow the classic Rails flow and look for a create.json view
      else
        format.html { render "restaurants/show" }
        format.json # Follow the classic Rails flow and look for a create.json view
      end
    end
  end

  private

  def strong_params
    params.require(:review)
          .permit(:comment, :rating)
  end
end
