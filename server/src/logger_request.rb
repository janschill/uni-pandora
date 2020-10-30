# frozen_string_literal: true

require 'date'

class LoggerRequest
  attr_reader :id, :time, :path

  def initialize(data:)
    @id = data[:id].to_i
    @time = data[:time]
    @path = data[:path]
  end

  def to_s
    "id: #{@id}, time: #{@time}, path: #{@path}"
  end
end
