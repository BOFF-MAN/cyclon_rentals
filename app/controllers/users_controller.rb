class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @name = current_user.name
    # @bikes = @user.bikes
  end
end
