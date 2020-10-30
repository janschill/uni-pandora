# frozen_string_literal: true

require_relative 'logger_request'
require_relative 'parser/logger'

class Logger
  PATH = 'output/logs/'

  def initialize; end

  def self.today
    today = Time.new
    today.strftime('%y-%m-%d')
  end

  def self.path
    "#{Dir.pwd}/#{PATH}"
  end

  def self.today_path
    "#{Dir.pwd}/#{PATH}#{today}"
  end

  def self.create_today_file
    return if File.exist?(today_path)

    File.open(today_path, 'w') { |f| }
  end

  def self.latest_id
    if File.exist?(today_path) && !File.zero?(today_path)
      last_row = File.open(today_path).readlines.map(&:chomp).last
      logger_request = LoggerRequest.new.from_logger(Parser::Logger.new.parse_row(row: last_row))
      logger_request.id
    elsif File.exist?(today_path) && File.zero?(today_path)
      1
    else
      create_today_file
      1
    end
  end

  def self.write(file:, content:)
    File.write("#{path}/#{file}", "#{content}\n", mode: 'a')
  end

  # def self.read_latest_entry
  #   file = File.open(path)
  # end

  def write_logger_request(logger_request:)
    Logger.write(file: Logger.today, content: logger_request.to_s)
  end
end

# Logger.create_today_file
# Logger.write(file: Logger.today, content: 'id: 2, clicked: start-button')
