class Apps::MembershipsController < Apps::ApplicationController
  def show
    @room = Room.new
  end

  def create
    @room = Room.find_by(name: room_params[:name])

    if @room && @room.authenticate_room_key(room_params[:room_key])

      if @room.members.find_by(id: current_user.id).nil?
        UserRoom.create!(user: current_user, room: @room)
        redirect_to room_path(@room), notice: 'ルームに参加しました'
      else
        flash.now[:error] = '既にこのルームに参加しています'
        render :show, status: :unprocessable_entity
      end

    else
      flash.now[:error] = 'ルームが見つかりませんでした'
      render :show, status: :unprocessable_entity
    end
  end

  private
  def room_params
    params.require(:room).permit(
      :name,
      :room_key
    )
  end
end
