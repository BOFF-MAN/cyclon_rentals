class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def search
    params[:query].present? ? @bikes = Bike.where("address ILIKE ?", "%#{params[:query]}%") : @bikes = Bike.all
    @markers = @bikes.geocoded.map do |bike|
       [{
          lat: bike.latitude,
          lng: bike.longitude,
          info_window: render_to_string(partial: "info_window", locals: { bike: bike }),
          image_url: helpers.asset_url("tyre.png")
       }]
     end
  end
end
