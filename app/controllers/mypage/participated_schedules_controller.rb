class Mypage::ParticipatedSchedulesController < Mypage::ApplicationController
  before_action :set_profile

  def index
    @schedules = current_user.participated_schedules.active.order(:start_time).includes(:creator, :room)
  end
end
