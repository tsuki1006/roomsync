class Apps::RoomsController < Apps::ApplicationController
  before_action :set_room, only: [ :show ]

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = current_user.created_rooms.build
  end

  def create
    @room = current_user.created_rooms.build
    @room.assign_attributes(room_params)
    if @room.save
      redirect_to room_path(@room), notice: 'ルームを作成しました'
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

  def set_room
    @room = Room.find(params[:id])
  end
end
