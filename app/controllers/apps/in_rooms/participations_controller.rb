class Apps::InRooms::ParticipationsController < Apps::InRooms::ApplicationController

  def create
    @schedule = @room.schedules.find(params[:schedule_id])
    current_user.participate!(@schedule)

    flash.now[:notice] = '予定に参加しました'
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to room_path(@room), notice: '予定に参加しました'}
    end
  end

  def destroy
    @schedule = current_user.participated_schedules.find(params[:schedule_id])
    current_user.unparticipate!(@schedule)

    flash.now[:notice] = '参加をキャンセルしました'
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to room_path(@room), notice: '参加をキャンセルしました'}
    end
  end
end
