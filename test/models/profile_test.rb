# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  comment      :string(80)
#  course       :integer          default(0), not null
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
require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
