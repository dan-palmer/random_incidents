APP_ENV = ENV.fetch('APP_ENV', 'development')

require 'dotenv'
Dotenv.load(File.expand_path("../../.#{APP_ENV}.env", __FILE__))

require 'celluloid/autostart'
require 'twilio-ruby'
require 'trello'
require 'active_support/core_ext/enumerable.rb'
require 'active_support/time'
require 'logger'
require 'pry'

Dir['./lib/**/*.rb'].each(&method(:require))

module RandomIncidents
  def logger
    @logger ||= Logger.new 'info.log'
  end

  def log(something)
    logger.info something
  end

  def log_error(badness)
    logger.error badness
  end

  def start
    Supervisor.run!.actors.map(&:run_async)
  end

  extend self
end
