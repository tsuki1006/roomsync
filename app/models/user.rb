# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        #  :recoverable,
         :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :created_rooms, foreign_key: 'creator_id', class_name: 'Room'
  has_many :created_schedules, foreign_key: 'creator_id', class_name: 'Schedule'

  has_many :room_joining_relationships, class_name: 'UserRoom', dependent: :destroy
  has_many :joined_rooms, through: :room_joining_relationships, source: :room

  has_many :participation_relationships, class_name: 'Participation', dependent: :destroy
  has_many :participated_schedules, through: :participation_relationships, source: :schedule

  delegate :name, :comment, :avatar, to: :profile, allow_nil: true

  def prepare_profile
    profile || build_profile
  end

  def participate!(schedule)
    participation_relationships.create!(schedule: schedule)
  end

  def unparticipate!(schedule)
    participation_relationships.find_by(schedule: schedule).destroy
  end
end
