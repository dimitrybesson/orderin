class OrderItemsController < ApplicationController

  def create
    @order_item = OrderItem.new(order_item_params)
    @order = @order_item.order
    @order_items = @order.order_items
    if @order_item.save
      @order_item.deduct_from_inventory
      render @order
    else
      # error message
    end
  end

  def update
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @inventory_item = @order_item.inventory_item

    @inventory_item.quantity += @order_item.quantity
    @inventory_item.save

    @order_item.destroy
    @order_item = OrderItem.new
    render @inventory_item
  end

  private
  def order_item_params
    params.require(:order_item).permit(:order_id, :inventory_item_id, :quantity)
  end
end
