class Mypage::CreatedSchedulesController < Mypage::ApplicationController
  before_action :set_profile

  def index
    @created_schedules = current_user.created_schedules.active
                          .order(:start_time)
                          .includes( :room, :participation_relationships)
    @participated_schedules = current_user.participated_schedules.active
  end
end
