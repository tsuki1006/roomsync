class Apps::InRooms::MembersController < Apps::InRooms::ApplicationController
  def show
    @user = @room.members.find(params[:id])
    if @user == current_user
      redirect_to profile_path
    end

    @profile = @user.profile
  end
end
