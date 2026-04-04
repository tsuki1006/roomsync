class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.find_by(email: 'guest@example.com')
    reset_guest_data(user)
    sign_in user
    redirect_to profile_path, notice: 'ゲストユーザーとしてログインしました'
  end

  private
  def reset_guest_data(user)
    user.created_rooms.destroy_all
    user.created_schedules.destroy_all
    user.participated_schedules.destroy_all
  end
end
