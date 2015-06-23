require 'simplecov'
require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'active_support/testing/time_helpers'
require 'random_incidents'

MONDAY_20TH_JULY =  Time.new(2015, 07, 20).freeze
FOLLOWING_MONDAY = (MONDAY_20TH_JULY + 1.week).freeze
START_OF_DAY = 10.hours.freeze
END_OF_DAY   = 17.hours.freeze

DAYS_WITH_DATES = Date::DAYS_INTO_WEEK.reduce({}) do |result, (day, day_number)|
  result.tap { |hash| hash[day] = MONDAY_20TH_JULY + day_number.days }
end.freeze

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.allow_http_connections_when_no_cassette = false

  # Redact Sensitive Twilio Credentials
  config.filter_sensitive_data("TWILIO_SID")    { ENV.fetch('twilio_account_sid') }
  config.filter_sensitive_data("TWILIO_TOKEN")  { ENV.fetch('twilio_auth_token') }
  config.filter_sensitive_data("SMS_FROM")      { ENV.fetch('sms_from_number') }
  config.filter_sensitive_data("SMS_TO")        { ENV.fetch('sms_to_number') }

  # Redact Sensitive Trello API Credentials
  config.filter_sensitive_data("TRELLO_DEV_PUB_KEY") { ENV.fetch('trello_developer_public_key') }
  config.filter_sensitive_data("TRELLO_TOKEN")       { ENV.fetch('trello_token') }
  config.filter_sensitive_data("BOARD_LIST_ID")      { ENV.fetch('trello_board_list_id') }

  config.hook_into :webmock
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.include ActiveSupport::Testing::TimeHelpers
end
