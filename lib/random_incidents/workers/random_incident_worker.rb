module RandomIncidents
  class RandomIncidentWorker
    include Celluloid

    attr_reader :action, :seconds_delay

    def initialize(action)
      @action = action
      configure_initial_delay!
    end

    def run_async
      async.run
    end

    def run
      loop { perform }
    end

    def perform
      RandomIncidents.log "#{@action.class.name} Job has been queued until #{Time.now + @seconds_delay}"
      Kernel.sleep @seconds_delay
      @action.call
      configure_another_delay!
    end

    private

    def configure_initial_delay!
      RandomDelay.can_delay_for_today? ? delay_today! : delay_tomorrow!
    end

    def delay_today!
      @seconds_delay = \
        RandomDelay.seconds_from_now_until_time_in TodayWorkingHours.range
    end

    def configure_another_delay!
      @seconds_delay = \
        RandomDelay.seconds_from_now_until_time_in WeekdayTomorrowWorkingHours.range
    end

    alias_method :delay_tomorrow!, :configure_another_delay!
  end
end
