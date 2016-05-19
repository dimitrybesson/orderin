class OrdersController < ApplicationController

  def index
    if params[:restaurant_ids] && params[:supplier_ids]
      puts "We have restaurants and suppliers *****************************"
      @orders = Order.where(restaurant_id: params[:restaurant_ids], supplier_id: params[:supplier_ids])
      render partial: '/orders/orders_collection'

    elsif params[:restaurant_ids]
      puts 'IN ORDERS CONTROLLER ************************'
      @restaurants = Restaurant.where(id: params[:restaurant_ids])
      @orders = @restaurants.map do |restaurant|
        restaurant.orders
      end.flatten
      render partial: '/orders/orders_collection'
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def new
    @user = current_user
    @order = Order.new
    @restaurants = current_user.restaurants
    render partial: 'order_form'
  end

  def create
    @order = Order.new(order_params)
    @order.status = {}
    if @order.save
      redirect_to edit_order_url(@order)
    else
      ## where to render if fail???
    end
  end

  def edit
    @order = Order.find(params[:id])

    redirect_to order_url(@order), notice: "Invoice created, order can no longer be updated." if @order.invoiced?

    @inventory_items = @order.accessible_items
    @order_item = OrderItem.new
    @order_items = @order.order_items

    if request.xhr?
      render partial: 'order_total'
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      @order.status[:submitted] = true
      @order.save
      redirect_to order_url(@order) # we will add logic to allow user to edit if status is not sent
    else
    end
  end

  private

  def order_params
    params.require(:order).permit(:restaurant_id, :supplier_id, :user_id, :instructions, :delivery_date, :status)
  end
end
