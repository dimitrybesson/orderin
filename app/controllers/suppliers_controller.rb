class SuppliersController < ApplicationController

  def index
    # @suppliers = Supplier.all


    if params[:restaurant_ids]
      @restaurants = Restaurant.where(id: params[:restaurant_ids])
      @suppliers = @restaurants.map do |restaurant|
          restaurant.suppliers
      end.flatten.uniq
      render @suppliers
    end
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      # redirect to
    else
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
    @inventory_items = @supplier.inventory_items
    @user = current_user
    @order = Order.new
    @restaurants = current_user.restaurants
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(supplier_params)
      #redirect
    else
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    #redirect
  end

  def supplier_params
    params.require(:supplier).permit(:name, :street_address, :phone)
  end

end
