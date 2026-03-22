# frozen_string_literal: true

module UserDecorator
  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

  def display_name
    if profile.present?
      profile.name
    else
      '未設定ユーザー'
    end
  end
end
