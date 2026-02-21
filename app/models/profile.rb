# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  comment      :string(80)
#  course       :integer          default("unset"), not null
#  github_url   :string
#  introduction :text
#  name         :string(20)       not null
#  x_url        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user

  # enum
  enum :course, [:unset, :other, :rails, :java ], default: :unset

  #バリデーション
  validates :name, presence: true, length: { in: 1..20 }
  validates :course, presence: true
  validates :introduction, length: { maximum: 100 }, allow_blank: true
  validates :comment, length: { maximum: 80 }, allow_blank: true

  VALID_X_URL_REGEX = /\Ahttps:\/\/(x|twitter)\.com\/[a-zA-Z0-9_]{3,15}\z/
  VALID_GITHUB_URL_REGEX = /\Ahttps:\/\/github\.com\/[a-zA-Z0-9-]+\z/

  validates :x_url,
  format: { with: VALID_X_URL_REGEX, message: 'はXのプロフィールURLを入力してください' },
  allow_blank: true

  validates :github_url,
  format: { with: VALID_GITHUB_URL_REGEX, message: 'はGitHubのプロフィールURLを入力してください' },
  allow_blank: true

end
