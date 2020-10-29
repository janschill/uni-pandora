# frozen_string_literal: true

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

  def self.latest_id
    read_latest_entry
    1
  end

  def self.create_today_file
    return if File.exist?(today_path)

    File.open(path, 'w') { |f| }
  end

  def self.write(file:, content:)
    File.write("#{path}/#{file}", "#{content}\n", mode: 'a')
  end

  # def self.read_latest_entry
  #   file = File.open(path)
  # end
end

Logger.create_today_file
Logger.write(file: Logger.today, content: 'id: 2, clicked: start-button')
