class BikesController < ApplicationController
  before_action :set_bike, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /bikes
  def index
    # @bikes = Bike.all
    @bikes = policy_scope(Bike)
    @markers = @bikes.geocoded.map do |bike|
      {
      lat: bike.latitude,
      lng: bike.longitude,
      info_window: render_to_string(partial: "info_window", locals: { bike: bike }),
      image_url: helpers.asset_url("bike-tyre.png")
      }
    end
  end

  # GET bikes/:id
  def show
    @bike = Bike.find(params[:id])
  end

  # GET /bikes/new
  def new
    @bike = Bike.new
    authorize @bike
  end

  # GET /bikes/:id/edit
  def edit
  end

  # POST /bikes
  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    authorize @bike
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
    @bike = Bike.new.find(params[:id])
    authorize @bike
  end

  def bike_params
    params.require(:bike).permit(:name, :description, :daily_rate, :address, :photo)
  end

end
