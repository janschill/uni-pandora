# frozen_string_literal: true

class Response
  attr_reader :code

  def initialize(code:, headers: [], data: '')
    headers = default_headers if headers.empty?
    @response = if data.eql?('')
                  "HTTP/1.1 #{code}\r\n"\
                  "#{headers.join('')}"
                else
                  "HTTP/1.1 #{code}\r\n"\
                  "#{headers.join('')}"\
                  "Content-Length: #{data.size}\r\n"\
                  "\r\n"\
                  "#{data}\r\n"
                end
    @code = code
  end

  def default_headers
    [
      "Access-Control-Allow-Origin: *\r\n",
      "Access-Control-Allow-Headers: Content-Type\r\n"\
    ]
  end

  def send(client:)
    client.write(@response)
  end
end
