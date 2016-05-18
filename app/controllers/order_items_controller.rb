class OrderItemsController < ApplicationController

  def create
    @order_item = OrderItem.new(order_item_params)
    if @order_item.quantity.nil?
      @order_item.quantity = 0
    end
    @order = @order_item.order
    @order_items = @order.order_items
    if @order_item.save
      @order_item.deduct_from_inventory
      render @order_item
    else
      # error message
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])

    #method
    delta = @order_item.quantity - params[:order_item][:quantity].to_i
    if @order_item.update_attributes(order_item_params)
      @order_item.update_inventory(delta)
      render @order_item
    else

    end
  end

  def mass_update

    params['formInfo'].each_value do |form_data|
      order_item_id = form_data[0].scan(/\d+\z/).first.to_i
      @order_item = OrderItem.find(order_item_id)
      delta = @order_item.quantity - form_data[1].to_i
      # sanitize
      if @order_item.update_attributes(quantity: form_data[1].to_i)
        @order_item.update_inventory(delta)
      end
    end
    render nothing:true
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
