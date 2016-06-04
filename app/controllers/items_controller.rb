class ItemsController < ApplicationController
  def index
    @items = Item.order('name')
  end

  def show
    @item = Item.find(params[:id])

    if request.xhr?
      @supplier = current_user.suppliers.first
      @inventory_item = InventoryItem.new(item_id: params[:id], supplier_id: @supplier.id, name: @item.name)
      render partial: 'new_inventory_from_existing_form'
    else
      @inventory_items = @item.inventory_items
    end
  end

  def new

  end

  def create
  end

  def update
  end

  def destroy
  end
end
