class InventoryItemsController < ApplicationController

  def index
    @supplier = Supplier.find(params[:supplier_id])
    @inventory_items = @supplier.inventory_items

    @order = Order.new
  end
end
