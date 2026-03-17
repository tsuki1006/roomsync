module CalendarsHelper
  def add_weekends_class(day)
      if day.wday == 0
        'sunday'
      elsif day.wday == 6
        'saturday'
      end
  end
end
