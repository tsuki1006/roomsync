# frozen_string_literal: true

module ScheduleDecorator
  def display_start_time
    I18n.l(self.start_time.time, format: :short)
  end

  def display_end_time
    I18n.l(self.end_time.time, format: :short)
  end
end
