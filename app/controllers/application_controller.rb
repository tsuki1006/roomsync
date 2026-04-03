class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # サインイン後の遷移先
  def after_sign_in_path_for(resource)
    profile_path
  end

  # ゲストユーザーの機能制限
  def guest_user_limitation(path)
    if user_signed_in? && current_user.email == 'guest@example.com'
      redirect_to path, alert: 'ゲストユーザーではこの機能は利用できません'
    end
  end
end
