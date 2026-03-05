class Apps::SchedulesController < Apps::ApplicationController
  before_action :set_room

  def new
    @schedule = current_user.created_schedules.build(room: @room)
  end

  def create
    @schedule = current_user.created_schedules.build(room: @room)
    @schedule.assign_attributes(schedule_params)

    if @schedule.save
      redirect_to room_path(@room), notice: '予定を作成しました'
    else
      flash.now[:error] = '予定の作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @schedule = current_user.created_schedules.find(params[:id])
  end

  def update
    @schedule = current_user.created_schedules.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to room_path(@room), notice: '予定を更新しました'
    else
      flash.now[:error] = '予定の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    schedule = current_user.created_schedules.find(params[:id])
    schedule.destroy!
    redirect_to room_path(@room), notice: '予定を削除しました'
  end

  private
  def schedule_params
    params.require(:schedule).permit(
      :start_time,
      :end_time,
      :status,
      :comment
    )
  end

  def set_room
    @room = current_user.joined_rooms.find_by(id: params[:room_id])
    if @room.nil?
      redirect_to profile_path, alert: 'このルームには参加していません'
    end
  end
end
