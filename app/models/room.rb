# == Schema Information
#
# Table name: rooms
#
#  id              :bigint           not null, primary key
#  description     :text
#  name            :string(50)       not null
#  room_key_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  creator_id      :bigint           not null
#
# Indexes
#
#  index_rooms_on_creator_id  (creator_id)
#  index_rooms_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#
class Room < ApplicationRecord
  has_secure_password :room_key
  belongs_to :creator, class_name: 'User'

  #バリデーション
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :room_key, length: { minimum: 6 }, allow_nil: true
end
