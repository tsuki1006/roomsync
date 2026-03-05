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
require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
