# frozen_string_literal: true

require_relative 'response'
require_relative 'logger'
require_relative 'logger_request'

class Router
  SERVER_ROOT = '/Users/janschill/code/janschill/uni-pandora/server/src/'

  def initialize; end

  def respond_with(code:, data: '')
    Response.new(code: code, data: data)
  end

  def respond(request:)
    case request.path
    # This is vulnerable to path traversal
    when '/'
      Response.new(code: 200, data: File.binread("#{SERVER_ROOT}index.html"))
    when '/id'
      id = Logger.new_id
      Response.new(code: 200, data: "{\"id\": #{id}}")
    when '/logger'
      if request.method == :POST
        logger_request = LoggerRequest.new(data: request.body)
        Logger.new.write_logger_request(logger_request: logger_request)
      end
      Response.new(code: 200, data: 'Logging successfully')
    else
      Response.new(code: 404)
    end
  end
end
