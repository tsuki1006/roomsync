class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.find_by(email: 'guest@example.com')
    sign_in user
    redirect_to profile_path, notice: 'ゲストユーザーとしてログインしました'
  end
end
