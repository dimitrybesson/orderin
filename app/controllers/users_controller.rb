class UsersController < ApplicationController
  def show
    @user = current_user
    if @user.restaurant_worker?
      @restaurants = @user.restaurants
      @order = Order.new
    elsif @user.supplier_worker?
      @supplier = @user.suppliers.first
      @submitted_orders = Order.find_by_sql("SELECT * FROM orders WHERE (status ? 'submitted') and NOT (status ? 'invoiced') and supplier_id = #{@supplier.id}")
      @invoiced_orders = Order.find_by_sql("SELECT * FROM orders WHERE (status ? 'invoiced') and NOT (status ? 'delivered') and supplier_id = #{@supplier.id}")
      @delivered_orders = Order.find_by_sql("SELECT * FROM orders WHERE (status ? 'delivered') and NOT (status ? 'paid') and supplier_id = #{@supplier.id}")
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
