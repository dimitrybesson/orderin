class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_restaurants = @user.restaurants

    if request.xhr?
      @restaurant= Restaurant.find(params[:restaurant_id])
      @suppliers = @restaurant.suppliers
      render @suppliers

    end

    # @restaurant.find(params[:restaurant_id])
  end
end
