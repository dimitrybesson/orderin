class UsersController < ApplicationController
  def show
    @user = current_user
    if @user.restaurant_worker?
      @restaurants = @user.restaurants
      @order = Order.new
    elsif @user.supplier_worker?
      @supplier = @user.suppliers.first
      @orders = @supplier.orders.where("delivery_date > NOW()")
    else
    end
    # if request.xhr?
      #   @restaurant= Restaurant.find(params[:restaurant_id])
      #   @suppliers = @restaurant.suppliers
      #   render @suppliers
    #
    # end


  end
end
