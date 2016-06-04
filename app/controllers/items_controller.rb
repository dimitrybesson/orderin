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
    @item = Item.new
    @supplier = current_user.suppliers.first
    render partial: 'new_inventory_from_scratch_form'
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      @inventory_item = InventoryItem.new(inventory_item_params)
      @inventory_item.item_id = @item.id
      if @inventory_item.save
        @supplier = current_user.suppliers.first
        render partial: '/inventory_items/inventory_item_index'
      else
        # error handling
      end
    else
      # error handling
    end
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.permit(:name, :description)
  end

  def inventory_item_params
    params.permit(:supplier_id, :quantity, :price, :name)
  end
end
