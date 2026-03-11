module MypageHelper
  def active_created_schedule_count(user)
      count = user.created_schedules.active.count
      count if count > 0
  end

  def active_participated_schedule_count(user)
      count = user.participated_schedules.active.count
      count if count > 0
  end
end
