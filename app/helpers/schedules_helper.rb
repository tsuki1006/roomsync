module SchedulesHelper
  def todays_schedule_count(schedules, date)
    count = 0
    schedules.each do |schedule|
      count += 1 if schedule.start_time.to_date == date
    end
    count == 0 ? nil : "#{count}件の予定"
  end
end
