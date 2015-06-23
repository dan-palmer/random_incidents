require './lib/random_incidents/work_times.rb'

module RandomIncidents
  module RandomDelay
    include WorkTimes

    def seconds_from_now_until_time_in(range)
      random_time_within_range = rand(range)
      random_time_within_range.minus_without_coercion(Time.now).floor
    end

    def can_delay_for_today?
      is_today_a_weekday? && within_todays_work_hours?
    end

    private

    def is_today_a_weekday?
      WEEKEND_DAY_NAMES.exclude? Date.today.strftime('%^A')
    end

    def within_todays_work_hours?
      Time.now < (Date.today + END_WORK_DAY)
    end

    extend self
  end
end
