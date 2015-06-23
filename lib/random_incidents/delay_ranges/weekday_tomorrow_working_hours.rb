require './lib/random_incidents/work_times.rb'

module RandomIncidents
  class WeekdayTomorrowWorkingHours
    include WorkTimes

    def self.range
      new.range
    end

    def range
      start_of_next_working_day..end_of_next_working_day
    end

    private

    def start_of_next_working_day
      next_weekday + START_WORK_DAY
    end

    def end_of_next_working_day
      next_weekday + END_WORK_DAY
    end

    def tomorrow
      @tomorrow ||= Date.tomorrow
    end

    def next_weekday
      case tomorrow.strftime('%^A')
      when 'SATURDAY' then tomorrow + 2.days
      when 'SUNDAY'   then tomorrow + 1.day
      else tomorrow
      end
    end
  end
end
