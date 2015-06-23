require './lib/random_incidents/work_times.rb'

module RandomIncidents
  class TodayWorkingHours
    include WorkTimes

    def self.range
      new.range
    end

    def range
      latest_allowable_start_time..end_of_work_today
    end

    private

    def latest_allowable_start_time
      now.to_date + [START_WORK_DAY, midnight_til_present_in_seconds].max
    end

    def midnight_til_present_in_seconds
      now.hour.hours + now.min.minutes + now.sec.seconds
    end

    def now
      @now ||= Time.now
    end

    def end_of_work_today
      now.to_date + END_WORK_DAY
    end
  end
end
