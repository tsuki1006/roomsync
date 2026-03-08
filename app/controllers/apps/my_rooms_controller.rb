class Apps::MyRoomsController < Apps::ApplicationController
  def show
    @room = current_user.joined_rooms
  end
end
