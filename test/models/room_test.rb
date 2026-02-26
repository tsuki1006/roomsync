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
require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
