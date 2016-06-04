class InventoryItemsController < ApplicationController

  before_action :user_works_for_this_supplier

  def index
    @supplier = Supplier.find(params[:supplier_id])
    @inventory_items = @supplier.inventory_items
    @order = Order.new

    if request.xhr?
      @items = (Item.all - Item.joins("JOIN inventory_items ON inventory_items.item_id=items.id").where("inventory_items.supplier_id = #{@supplier.id}")).sort { | a, b | a.name <=> b.name }
      render partial: 'inventory_item_suggestions'
    end
  end

  def new
  end

  def create
    @inventory_item = InventoryItem.new(inventory_item_params)
    if @inventory_item.save
      @supplier = @inventory_item.supplier
      render partial: 'inventory_item_index'
    else
      # error handling
    end
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

  def user_works_for_this_supplier
    unless current_user.works_at?(params[:supplier_id], "Supplier")
      redirect_to root_url
    end
  end
end
