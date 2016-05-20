class ItemsController < ApplicationController
  def index
    @items = Item.order('name')
  end

  def show
    @item = Item.find(params[:id])
    @inventory_items = @item.inventory_items
  end

  def create
  end

  def update
  end

  def destroy
  end
end
