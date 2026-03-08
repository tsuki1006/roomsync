# == Schema Information
#
# Table name: participations
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  schedule_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_participations_on_schedule_id              (schedule_id)
#  index_participations_on_schedule_id_and_user_id  (schedule_id,user_id) UNIQUE
#  index_participations_on_user_id                  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (schedule_id => schedules.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
