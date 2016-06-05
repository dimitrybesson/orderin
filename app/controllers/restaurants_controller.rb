class RestaurantsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
    render partial: 'form'
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      @permission = Permission.new(user_id: current_user.id, role_id: Role.find_by(name: 'master').id, institution_id: @restaurant.id, institution_type: "Restaurant")
      if @permission.save
        redirect_to user_url(current_user)
      else
        # error handling
      end
    else
      # error handling
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :street_address, :phone)
  end

end
