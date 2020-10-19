# frozen_string_literal: true

require_relative 'response'

class Router
  SERVER_ROOT = '/Users/janschill/code/janschill/uni-pandora/server/src/'
  def initialize; end

  def respond_with(code:, data: '')
    Response.new(code: code, data: data)
  end

  def respond(request:)
    case request[:path]
    # This is vulnerable to path traversal
    when '/'
      Response.new(code: 200, data: File.binread("#{SERVER_ROOT}index.html"))
    when '/logger'
      Response.new(code: 200, data: 'test')
    else
      Response.new(code: 404)
    end
  end
end
