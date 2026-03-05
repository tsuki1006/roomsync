# == Schema Information
#
# Table name: user_rooms
#
#  id         :bigint           not null, primary key
#  role       :integer          default("member"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_rooms_on_room_id              (room_id)
#  index_user_rooms_on_user_id              (user_id)
#  index_user_rooms_on_user_id_and_room_id  (user_id,room_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (user_id => users.id)
#
class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # enum
  enum :role, [:member, :owner ], default: :member

  # バリデーション
  validates :user_id, uniqueness: { scope: :room_id,
    message: '既にこのルームに参加しています' }
end
