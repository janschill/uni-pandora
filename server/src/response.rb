# frozen_string_literal: true

class Response
  attr_reader :code

  def initialize(code:, data: '')
    @response =
      "HTTP/1.1 #{code}\r\n"\
      "Access-Control-Allow-Origin: *\r\n"\
      "Access-Control-Allow-Headers: Content-Type\r\n"\
      "Content-Length: #{data.size}\r\n"\
      "\r\n"\
      "#{data}\r\n"
    @code = code
  end

  def send(client:)
    client.write(@response)
  end
end
