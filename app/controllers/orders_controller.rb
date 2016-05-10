class OrdersController < ApplicationController

  def index
    #@restaurant = Restaurant.find(session[restaurant_id]) This will be the restaurant that the current user is order for
    @orders = Order.all # This will have to account for specific restuarant later
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to edit_order_url(@order)
    else
      ## where to render if fail???
    end
  end

  def edit
    @order = Order.find(params[:id])
    @inventory_items = @order.supplier.inventory_items
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      redirect_to order_url(@order) # we will add logic to allow user to edit if status is not sent
    else
    end
  end

  private

  def order_params
    params.require(:order).permit(:restaurant_id, :supplier_id, :user_id, :instructions, :delivery_date, :status)
  end
end
