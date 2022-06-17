require "logger"

module Logging
  def logger
    Logging.logger
  end

  def self.logger
    @logger ||= initialise_logger
  end

  def self.initialise_logger
    logger = Logger.new(STDOUT, level: :info)
    logger.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.strftime("%Y-%m-%d %H:%M:%S.%L")
      "[#{date_format}] #{severity}: #{msg}\n"
    end
    logger
  end
end
