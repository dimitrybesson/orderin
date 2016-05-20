class HomeController < ApplicationController

  before_action :check_signed_in, only: :index

  def index
    render layout: false
  end

  private

  def check_signed_in
    redirect_to user_url(current_user) if user_signed_in?
  end
end
