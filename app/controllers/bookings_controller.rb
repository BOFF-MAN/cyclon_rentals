class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :find_bike, only: [:new, :create]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
    # @bike = Bike.find(params[:find_bike])
  end

  def create
    @bike = Bike.find(params[:bike_id])
    @user = User.find(params[:user_id])
    @booking = Booking.new(booking_params)
    @booking.bike = @bike
    @booking.user = @user
    start_date = Date.parse(bookings_params[:start_date])
    end_date = Date.parse(bookings_params[:end_date])
    total_days = (end_date - start_date).to_i + 1
    total_price = total_days * @bike.daily_rate
    @booking.total = total_price

    if current_user == @bike.user
      flash[:alert] = "Cannot book your own bike!"
      render :new
    elsif @booking.save
      redirect_to bikes_path
    else
      render :new
    end
  end

  def show
    @bike = @booking.bike
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def find_bike
    @bike = Bike.find(params[:bike_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :bike_id)
  end
end
