# frozen_string_literal: true

require 'json'

class Parser
  def initialize; end

  def text_html?(content_type:)
    content_type == 'text/html'
  end

  def application_json?(content_type:)
    content_type == 'application/json'
  end

  def application_x_www_form?(content_type:)
    content_type == 'application/x-www-form-urlencoded'
  end

  def empty_line?(str:)
    str == "\r\n"
  end

  def normalize(header:)
    header.gsub(':', '').downcase.to_sym
  end

  # Only supports HTML at the moment
  def parse_body_to_html_string(lines:, content_type:)
    return unless text_html?(content_type: content_type)

    html_string = ''
    lines.each do |line|
      html_string += line
    end
    html_string
  end

  def parse_headers; end

  def parse_request(request:)
    headers = {}
    body_start = 0

    request.lines[1..-1].each_with_index do |line, index|
      body_start = index
      break if line == "\r\n"

      header, value = line.split
      header = normalize(header: header)
      headers[header] = value
    end

    body = parse_body_to_html_string(
      lines: request.lines[body_start + 1..-1],
      content_type: headers[:"content-type"]
    )

    { headers: headers, body: body }
  end

  def read(request:)
    method, path, _version = request.lines[0].split
    {
      path: path,
      method: method,
      headers: parse_request(request: request)[:headers],
      body: parse_request(request: request)[:body]
    }
  end
end
