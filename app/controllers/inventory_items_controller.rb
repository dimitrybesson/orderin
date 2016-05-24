class InventoryItemsController < ApplicationController

  def index
    @supplier = Supplier.find(params[:supplier_id])
    @inventory_items = @supplier.inventory_items

    @order = Order.new
  end

  def edit
    @supplier = Supplier.find(params[:supplier_id])
    @inventory_item = InventoryItem.find(params[:id])
    render partial: 'edit_inventory_item'
  end

  def update
    @supplier = Supplier.find(params[:supplier_id])
    @inventory_item = InventoryItem.find(params[:id])
    if @inventory_item.update_attributes(inventory_item_params)
      render partial: 'supplier_inventory_item'
    else
      # error handling
    end
  end

  private

  def inventory_item_params
    params.require(:inventory_item).permit(:item_id, :supplier_id, :quantity, :price, :name)
  end
end
