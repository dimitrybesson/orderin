class OrderItemsController < ApplicationController

  def create
    @order_item = OrderItem.new(order_item_params)
    @order = @order_item.order
    @order_items = @order.order_items
    if @order_item.save
      render @order
    else
      # error message
    end
  end

  def update
  end

  def destroy
  end

  private
  def order_item_params
    params.require(:order_item).permit(:order_id, :inventory_item_id, :quantity)
  end
end
