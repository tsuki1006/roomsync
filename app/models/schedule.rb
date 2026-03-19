# == Schema Information
#
# Table name: schedules
#
#  id         :bigint           not null, primary key
#  comment    :string(50)
#  end_time   :datetime         not null
#  start_time :datetime         not null
#  status     :integer          default("mokumoku"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :bigint           not null
#  room_id    :bigint           not null
#
# Indexes
#
#  index_schedules_on_creator_id  (creator_id)
#  index_schedules_on_room_id     (room_id)
#  index_schedules_on_start_time  (start_time)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#  fk_rails_...  (room_id => rooms.id)
#
class Schedule < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :room

  has_many :participation_relationships, class_name: 'Participation', dependent: :destroy
  has_many :participants, through: :participation_relationships, source: :user

  # enum
  enum :status, [ :mokumoku, :talking_ok, :help_me ], default: :mokumoku

  # バリデーション
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :status, presence: true
  validates :comment, length: { maximum: 50 }, allow_blank: true

  validate :start_finish_check
  validate :start_check
  validate :less_than_24h_check
  validate :duplicates_check
  validate :time_15_minute_interval_check

  def start_finish_check
    return if start_time.blank? || end_time.blank?
    errors.add(:end_time, 'は開始時間以降の時間を選択してください') if start_time > end_time
  end

  def start_check
    return if start_time.blank?
    errors.add(:start_time, 'は現在の日時以降の時間を選択してください') if start_time < Time.current
  end

  def less_than_24h_check
    return if start_time.blank? || end_time.blank?
    seconds_per_day = 60*60*24
    errors.add(:end_time, 'は開始から24h以内に設定してください') if end_time - start_time > seconds_per_day
  end

  def duplicates_check
    return if start_time.blank? || end_time.blank?

    if Schedule.where.not(id: self.id)
              .where(creator_id: self.creator_id)
              .where(room_id: self.room_id)
              .where('end_time > ? and ? > start_time', self.start_time, self.end_time).present?
      errors.add(:base, '同じ時間帯に複数の予定を作成することはできません')
    end
  end

  def time_15_minute_interval_check
    return if start_time.blank? || end_time.blank?

    unless start_time.min % 15 == 0 && end_time.min % 15
      errors.add(:base, '時刻は15分単位で入力してください')
    end
  end

  # スコープ
  scope :active, -> { where('end_time > ?', Time.current) }

  # メソッド
  def active?
    Schedule.active.exists?(id: self.id)
  end
end
