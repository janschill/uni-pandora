# frozen_string_literal: true

require 'date'

class LoggerRequest
  attr_reader :id, :time, :location, :click

  def initialize(data:)
    @id = data[:id].to_i
    @time = data[:time]
    @location = data[:location]
    @click = data[:click]
  end

  def to_s
    "id: #{@id}, time: #{@time}, location: #{@location}, click: #{@click}"
  end
end
