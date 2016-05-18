class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.all
    if params[:restaurant_ids]
      @restaurant= Restaurant.find(params[:restaurant_id])
      @suppliers = @restaurant.suppliers
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