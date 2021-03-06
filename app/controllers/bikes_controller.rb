class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /bikes
  def index
    params[:query].present? ? @bikes = Bike.where("address ILIKE ?", "%#{params[:query]}%") : @bikes = Bike.all
    @markers = @bikes.geocoded.map do |bike|
      {
         lat: bike.latitude,
         lng: bike.longitude,
         info_window: render_to_string(partial: "info_window", locals: { bike: bike }),
         image_url: helpers.asset_url("tyre.png")
      }
    end
  end

  # GET bikes/:id
  def show
    @bike = Bike.find(params[:id])
    @booking = Booking.new
    @bookings = @bike.bookings
    @users_booked = @bookings.map {|booking| booking.user}
    @review = Review.new
    @markers =
      [{
        lat: @bike.latitude,
        lng: @bike.longitude,
        info_window: render_to_string(partial: "info_window", locals: { bike: @bike }),
        image_url: helpers.asset_url("tyre.png")
      }]
  end

  # GET /bikes/new
  def new
    @bike = Bike.new

  end

  # GET /bikes/:id/edit
  def edit
  end

  # POST /bikes
  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    # authorize @bike
    if @bike.save
      redirect_to bike_path(@bike)
    else
      render :new
    end
  end

  #PATCH/PUT /bikes/:id
  def update
    if @bike.update(bike_params)
      redirect_to @bike, notice: "Listing was updated!"
    else
      render :edit
    end
  end

  # DELETE /bikes/:id
  def destroy
    @bike.destroy
    redirect_to bikes_url, notice: "Bike was removed!"
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
    authorize @bike
  end

  def bike_params
    params.require(:bike).permit(:name, :description, :daily_rate, :address, :photo, :category)
  end

end
