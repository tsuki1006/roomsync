class Apps::InRooms::ApplicationController < Apps::ApplicationController
  before_action :set_room

  private
  def set_room
    @room = current_user.joined_rooms.find_by(id: params[:room_id])
    if @room.nil?
      redirect_to profile_path, alert: 'このルームには参加していません'
    end
  end
end
