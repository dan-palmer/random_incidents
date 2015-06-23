require 'spec_helper'

RSpec.describe RandomIncidents::TodayWorkingHours do

  let(:a_work_day) { Time.new 2015, 07, 27 }
  let(:end_of_work_day) { a_work_day + 17.hours }

  describe '.range' do
    context 'before the start of the work day' do
      let(:time_before_work_day_starts) { a_work_day + 2.hours }
      it 'creates a range between the default start time and the end of the work day' do
        travel_to(time_before_work_day_starts) do
          start_of_work_day = a_work_day + 10.hours
          expect(described_class.range).to eq start_of_work_day..end_of_work_day
        end
      end
    end
    context 'after the start of the work day' do
      let(:time_after_work_day_has_started) { a_work_day + 12.hours + 30.minutes }
      it 'creates a range from the time range is called until the end of the work day' do
        travel_to(time_after_work_day_has_started) do
          expect(described_class.range).to eq time_after_work_day_has_started..end_of_work_day
        end
      end
    end
  end
end
