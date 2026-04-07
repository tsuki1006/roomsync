class Mypage::ProfilesController < Mypage::ApplicationController
  before_action :set_profile, only: [:show]
  before_action ->{ guest_user_limitation(edit_profile_path) }, only: [:update]

  def show
    @created_schedules = current_user.created_schedules.active
    @participated_schedules = current_user.participated_schedules.active
  end

  def edit
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィールを更新しました'
    else
      flash.now[:error] = 'プロフィールの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def profile_params
    params.require(:profile).permit(
      :name,
      :introduction,
      :course,
      :comment,
      :x_url,
      :github_url,
      :avatar
    )
  end
end
