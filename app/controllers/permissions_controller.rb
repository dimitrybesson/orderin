class PermissionsController < ApplicationController

  def index
    @permissions = Permission.where(user_id: current_user.id, role: 1)
  end

  def new
    @permission = Permission.new
    @restaurant = Restaurant.find(params[:data])
    render partial: 'permission_new_form'
  end

  def create
    @permission = Permission.new(permission_params)
    @permission.user_id = User.find_by(email: params[:permission][:user_id].to_s).id
    if @permission.save
      render nothing: true
    else
      # error handling
    end
  end

  def edit
    @permission = Permission.find(params[:id])
    render partial: 'permission_update_form'
  end

  def update
    @permission = Permission.find(params[:id])
    if @permission.update_attributes(permission_params)
      render nothing: true
    else
      # error handling?
    end
  end

  private

  def permission_params
    params.require(:permission).permit(:user_id, :role_id, :institution_id, :institution_type)
  end
end
