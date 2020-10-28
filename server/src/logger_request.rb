# frozen_string_literal: true

require 'date'

class LoggerRequest
  attr_reader :id, :time, :path

  def initialize(request:)
    @id = request[:id].to_i
    @time = Date.strptime(request[:time])
    @path = request[:path]
  end
end
