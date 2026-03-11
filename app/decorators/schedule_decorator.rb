# frozen_string_literal: true

module ScheduleDecorator
  def display_start_time
    I18n.l(self.start_time.time, format: :short)
  end

  def display_end_time
    I18n.l(self.end_time.time, format: :short)
  end

  def display_date
    start_day = self.start_time.to_date
    end_day = self.end_time.to_date
    if start_day == end_day
      l(start_day, format: :long_md)
    else
      "#{l(start_day, format: :long_md)} ~ #{l(end_day, format: :long_md)}"
    end
  end
end
