class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @restaurants = @user.restaurants
    @order = Order.new

    # if request.xhr?
      #   @restaurant= Restaurant.find(params[:restaurant_id])
      #   @suppliers = @restaurant.suppliers
      #   render @suppliers
    #
    # end


  end
end
