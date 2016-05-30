class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    if params[:restaurant_ids] && params[:supplier_ids]
      @orders = Order.where(restaurant_id: params[:restaurant_ids], supplier_id: params[:supplier_ids]).order(id: :desc).first(10)
      render partial: '/orders/orders_collection'

    elsif params[:restaurant_ids]
      @restaurants = Restaurant.where(id: params[:restaurant_ids])
      @orders = @restaurants.map do |restaurant|
        restaurant.orders
      end.flatten.sort{|a,b| b.id <=> a.id}[0, 5]
      render partial: '/orders/orders_collection'
    end

    if current_user.restaurant_worker?
      @orders = current_user.restaurants.map do |restaurant|
        restaurant.orders
      end.flatten.sort{|a,b| b.id <=> a.id}
    end

    if current_user.supplier_worker?
      @orders = Order.find_by_sql("SELECT * FROM orders
                                  WHERE (status ? 'submitted')
                                  AND supplier_id = #{current_user.suppliers[0].id}
                                  ORDER BY id DESC")
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items

    if current_user.supplier_worker?
      @order.seen
    end

    if request.xhr?
      if params[:search]
       @inventory_items = @order.accessible_items.where('name ilike ?', "%#{params[:search]}%")
       @order_item = OrderItem.new
       render @inventory_items
      else
        render partial: 'supplier_show_popup'
      end
    end
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
    if request.xhr?
      if @order.shipped?
        @order.status[:received] = true
      elsif @order.invoiced?
        @order.status[:shipped] = true
      end
      if @order.save
        render nothing: true
      else
        # error handling
      end
    elsif @order.update_attributes(order_params)
      @order.status[:submitted] = true
      @order.save
      redirect_to order_url(@order) # we will add logic to allow user to edit if status is not sent
    else
    end
  end

  def deliver
    @orders = current_user.deliveries
    render partial: 'deliveries'
  end

  private

  def order_params
    params.require(:order).permit(:restaurant_id, :supplier_id, :user_id, :instructions, :delivery_date, :status)
  end
end
