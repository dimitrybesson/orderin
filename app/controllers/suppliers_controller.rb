class SuppliersController < ApplicationController

  def index
    if params[:restaurant_ids]
      @restaurants = Restaurant.where(id: params[:restaurant_ids])
      @suppliers = @restaurants.map do |restaurant|
          restaurant.suppliers
      end.flatten.uniq
      render @suppliers
    end

    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
    render partial: 'form'
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      @permission = Permission.new(user_id: current_user.id, role_id: 1, institution_id: @supplier.id, institution_type: "Supplier")
      if @permission.save
        redirect_to user_url(current_user)
      else
        # error handling
      end
    else
      # error handling
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
