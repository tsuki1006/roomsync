class Mypage::CreatedSchedulesController < Mypage::ApplicationController
  before_action :set_profile

  def index
    @schedules = current_user.created_schedules.active.order(:start_time).includes(:creator, :room)
  end
end
