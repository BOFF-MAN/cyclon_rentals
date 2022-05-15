class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :find_bike, only: [:new, :create]

  def index
    @bookings = Booking.all
  end

  def show
    # calling set_booking
    @bike = @booking.bike
  end

  def new
    @booking = Booking.new
  end

  def create
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.bike = @bike
    @booking.user = @user
    total_price_calc

    if current_user == @bike.user
      flash[:alert] = "Cannot book your own bike!"
      render :new
    elsif @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  def edit
    # calling set_booking
    @bike = @booking.bike
  end

  def update
    # calling set_booking
    @bike = @booking.bike
    total_price_calc
    @booking.update(booking_params)
    redirect_to bookings_path
  end

  def destroy
    # calling set_booking
    @booking.destroy
    redirect_to bookings_path
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

  def total_price_calc
    start_date = Date.parse(booking_params[:start_date])
    end_date = Date.parse(booking_params[:end_date])
    total_days = (end_date - start_date).to_i + 1
    total_price = total_days * @bike.daily_rate
    @booking.total = total_price
  end
end
