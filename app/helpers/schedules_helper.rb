module SchedulesHelper
  def todays_schedule_count(schedules, date)
    count = 0
    schedules.each do |schedule|
      count += 1 if schedule.start_time.to_date == date
    end
    count == 0 ? nil : "#{count}件の予定"
  end

  def current_time_15min_rounded
    interval = 15
    time = Time.current
    rounded_min = (time.min.to_f / interval).ceil * interval
    rounded_current_time = time.change(min: 0) + rounded_min.minutes
    rounded_current_time.strftime('%Y-%m-%dT%H:%M')
  end

  def start_time_auto_fill(schedule)
    schedule.new_record? ? "#{params[:date]}T00:00" : schedule.start_time
  end

  def end_time_auto_fill(schedule)
    schedule.new_record? ? "#{params[:date]}T00:00" : schedule.end_time
  end

  def schedule_form_cancel_path(room, schedule)
    date = schedule.new_record? ? params[:date] : schedule.start_time.strftime('%Y-%m-%d')
    room_path(room, about: date)
  end
end
