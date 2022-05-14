class BookingsController < ApplicationController
  before_action :authenticate_user!


  def create
     bike = Bike.find(params[:bike_id])

     if current_user == room.user
        flash[:alert] = "Cannot book your own bike!"
     else
      start_date = Date.parse(bookings_params[:start_date])
      end_date = Date.parse(bookings_params[:end_date])
      total = (end_date - start_date).to_i + 1
     end
  end
end
