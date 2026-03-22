class Apps::RoomsController < Apps::ApplicationController
  before_action :set_room, only: [ :show ]

  def show
    @schedules = @room.schedules.includes(
      participants: { profile: :avatar_attachment },
      creator: { profile: :avatar_attachment }
    )
  end

  def new
    @room = current_user.created_rooms.build
  end

  def create
    @room = current_user.created_rooms.build
    @room.assign_attributes(room_params)
    if @room.save
      redirect_to room_path(@room, format: :html), notice: 'ルームを作成しました'
    else
      flash.now[:error] = 'ルームの作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def room_params
    params.require(:room).permit(
      :name,
      :room_key,
      :description
    )
  end

  private
  def set_room
    @room = current_user.joined_rooms.find_by(id: params[:id])
    if @room.nil?
      redirect_to profile_path, alert: 'このルームには参加していません'
    end
  end
end
