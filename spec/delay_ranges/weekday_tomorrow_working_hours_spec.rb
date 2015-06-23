require 'spec_helper'

RSpec.describe RandomIncidents::WeekdayTomorrowWorkingHours do

  describe '.range' do
    following_day_is_a_weekday = DAYS_WITH_DATES.except :friday, :saturday

    following_day_is_a_weekday.each do |day_name, date|
      context "when the current day is #{day_name}" do
        it "returns a range of the working hours for the following day" do
          expected_start_of_range = date + START_OF_DAY + 1.day
          expected_end_of_range   = date + END_OF_DAY + 1.day

          travel_to(date) do
            expect(described_class.range).
              to eq expected_start_of_range..expected_end_of_range
          end
        end
      end
    end

    following_day_is_a_weekend = DAYS_WITH_DATES.slice :friday, :saturday

    following_day_is_a_weekend.each do |day_name, date|
      context "when the current day(e.g #{day_name}) is followed by a weekend day" do
        it 'returns a range of the working hours for the next working day(monday)' do
          expected_start_of_range = FOLLOWING_MONDAY + START_OF_DAY
          expecetd_end_of_range   = FOLLOWING_MONDAY + END_OF_DAY

          travel_to(date) do
            expect(described_class.range).
              to eq expected_start_of_range..expecetd_end_of_range
          end
        end
      end
    end
  end
end
