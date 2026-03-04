# == Schema Information
#
# Table name: user_rooms
#
#  id         :bigint           not null, primary key
#  role       :integer          default(0), not null
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
require 'test_helper'

class UserRoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
