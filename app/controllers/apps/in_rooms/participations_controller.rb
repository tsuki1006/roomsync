class Apps::InRooms::ParticipationsController < Apps::InRooms::ApplicationController

  def create
    schedule = @room.schedules.find(params[:schedule_id])
    current_user.participate!(schedule)
    redirect_to room_path(@room), notice: '予定に参加しました'
  end

  def destroy
    schedule = current_user.participated_schedules.find(params[:schedule_id])
    current_user.unparticipate!(schedule)
    redirect_back fallback_location: profile_path, notice: '参加をキャンセルしました'
  end
end
