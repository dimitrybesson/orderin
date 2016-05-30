class UsersController < ApplicationController
  def show
    @user = current_user
    if @user.restaurant_worker?
      @restaurants = @user.restaurants
      @order = Order.new
      render 'restaurant_worker_dashboard'
    elsif @user.supplier_worker?
      @supplier = @user.suppliers.first
      @submitted_orders = Order.find_by_sql("SELECT * FROM orders WHERE (status ? 'submitted') and NOT (status ? 'invoiced') and supplier_id = #{@supplier.id}")
      @invoiced_orders = Order.find_by_sql("SELECT * FROM orders WHERE (status ? 'invoiced') and NOT (status ? 'shipped') and supplier_id = #{@supplier.id}")
      @shipped_orders = Order.find_by_sql("SELECT * FROM orders WHERE (status ? 'shipped') and NOT (status ? 'received') and supplier_id = #{@supplier.id}")
      @delivered_orders = Order.find_by_sql("SELECT * FROM orders WHERE (status ? 'received') and NOT (status ? 'paid') and supplier_id = #{@supplier.id}")
      render 'supplier_worker_dashboard'
    else
      render 'new_user_dashboard'
    end
    # if request.xhr?
      #   @restaurant= Restaurant.find(params[:restaurant_id])
      #   @suppliers = @restaurant.suppliers
      #   render @suppliers
    #
    # end


  end
end
