class ReviewsController < ApplicationController
  before_action :find_bike, only: [:index, :new, :create]

  def index
    @reviews = Review.where(bike: @bike)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.bike = @bike
    @review.user = current_user

    if @review.save
      redirect_to bike_path(@bike)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def find_bike
    @bike = Bike.find(params[:bike_id])
  end

end
