class Mypage::ApplicationController < ApplicationController
  before_action :authenticate_user!

  def set_profile
    @profile = current_user.profile
  end
end
