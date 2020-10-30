# frozen_string_literal: true

require 'date'

class LoggerRequest
  attr_reader :id, :time, :path

  def initialize; end

  def from_logger(row:)
    @id = row.id.to_i
    @time = Date.strptime(row.time)
    @path = row.path
    self
  end

  def from_http(body:)
    @id = body[:id].to_i
    @time = Date.strptime(body[:time])
    @path = body[:path]
    self
  end

  def to_s
    "id: #{@id}, time: #{@time}, path: #{@path}"
  end
end
