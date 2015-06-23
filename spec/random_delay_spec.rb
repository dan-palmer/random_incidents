require 'spec_helper'

RSpec.describe RandomIncidents::RandomDelay do

  let(:sample_range) { Time.new(2015, 7, 29, 10)..Time.new(2015, 7, 29, 17) }

  around { |spec| travel_to(Time.new(2015, 7, 28, 12)) { spec.run } }

  describe '.seconds_from_now_until_time_in' do
    context 'when provided a given timeframe in the form of a range' do
      it 'returns a delay in seconds from now until a random time in the range' do
        Array.new(100) { subject.seconds_from_now_until_time_in sample_range }.
          each do |delay|
            random_time_within_range = Time.now + delay
            expect(sample_range.cover?(random_time_within_range)).to be_truthy
          end
      end
    end
  end

  describe '.can_delay_for_today?' do
    context 'it is a work day' do
      weekdays = DAYS_WITH_DATES.except :saturday, :sunday

      context 'the current time does not exceed the latest working hour' do
        it 'returns true' do
          weekdays.each do |_, date|
            travel_to(date + START_OF_DAY) { expect(subject.can_delay_for_today?).to be_truthy }
          end
        end
      end

      context 'the current hour exceeds the latest working hour' do
        it 'returns false' do
          weekdays.each do |_, date|
            travel_to(date + END_OF_DAY + 1.hour) { expect(subject.can_delay_for_today?).to be_falsey }
          end
        end
      end
    end

    context 'it is a weekend' do
      weekend_days = DAYS_WITH_DATES.slice :saturday, :sunday
      it 'returns false' do
        weekend_days.each do |_, date|
          travel_to(date + START_OF_DAY) { expect(subject.can_delay_for_today?).to be_falsey }
        end
      end
    end
  end
end
