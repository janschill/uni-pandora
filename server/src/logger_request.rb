# frozen_string_literal: true

require 'date'

class LoggerRequest
  attr_reader :id, :time, :path

  def initialize(body:)
    @id = body[:id].to_i
    @time = Date.strptime(body[:time])
    @path = body[:path]
  end
end
