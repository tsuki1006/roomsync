class HomeController < ApplicationController
  def show
    redirect_to profile_path if user_signed_in?
  end
end
